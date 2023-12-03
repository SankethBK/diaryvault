package com.afur.flutter_html_to_pdf

import android.annotation.SuppressLint
import android.content.Context
import android.os.Build
import android.print.PdfPrinter
import android.print.PrintAttributes
import android.webkit.WebView
import android.webkit.WebViewClient

import java.io.File


class HtmlToPdfConverter {

    interface Callback {
        fun onSuccess(filePath: String)
        fun onFailure()
    }

    @SuppressLint("SetJavaScriptEnabled")
    fun convert(filePath: String, applicationContext: Context, callback: Callback) {
        val webView = WebView(applicationContext)
        val htmlContent = File(filePath).readText(Charsets.UTF_8)
        webView.settings.javaScriptEnabled = true
        webView.settings.javaScriptCanOpenWindowsAutomatically = true
        webView.settings.allowFileAccess = true
        webView.loadDataWithBaseURL(null, htmlContent, "text/HTML", "UTF-8", null)
        webView.webViewClient = object : WebViewClient() {
            override fun onPageFinished(view: WebView, url: String) {
                super.onPageFinished(view, url)
                createPdfFromWebView(webView, applicationContext, callback)
            }
        }
    }

    fun createPdfFromWebView(webView: WebView, applicationContext: Context, callback: Callback) {
        val path = applicationContext.filesDir
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {

            val attributes = PrintAttributes.Builder()
                .setMediaSize(PrintAttributes.MediaSize.ISO_A4)
                .setResolution(PrintAttributes.Resolution("pdf", "pdf", 600, 600))
                .setMinMargins(PrintAttributes.Margins.NO_MARGINS).build()

            val printer = PdfPrinter(attributes)

            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                val adapter = webView.createPrintDocumentAdapter(temporaryDocumentName)

                printer.print(adapter, path, temporaryFileName, object : PdfPrinter.Callback {
                    override fun onSuccess(filePath: String) {
                        callback.onSuccess(filePath)
                    }

                    override fun onFailure() {
                        callback.onFailure()
                    }
                })
            }
        }
    }

    companion object {
        const val temporaryDocumentName = "TemporaryDocumentName"
        const val temporaryFileName = "TemporaryDocumentFile.pdf"
    }
}