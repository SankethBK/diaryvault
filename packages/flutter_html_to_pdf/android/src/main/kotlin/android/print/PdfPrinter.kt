package android.print

import android.os.Build
import android.os.CancellationSignal
import android.os.ParcelFileDescriptor
import java.io.File

class PdfPrinter(private val printAttributes: PrintAttributes) {

    interface Callback {
        fun onSuccess(filePath: String)
        fun onFailure()
    }


    fun print(
        printAdapter: PrintDocumentAdapter,
        path: File,
        fileName: String,
        callback: Callback
    ) {
        // Support for min API 16 is required
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
            printAdapter.onLayout(
                null,
                printAttributes,
                null,
                object : PrintDocumentAdapter.LayoutResultCallback() {

                    override fun onLayoutFinished(info: PrintDocumentInfo, changed: Boolean) {
                        printAdapter.onWrite(arrayOf(PageRange.ALL_PAGES),
                            getOutputFile(path, fileName),
                            CancellationSignal(),
                            object : PrintDocumentAdapter.WriteResultCallback() {

                                override fun onWriteFinished(pages: Array<PageRange>) {
                                    super.onWriteFinished(pages)

                                    if (pages.isEmpty()) {
                                        callback.onFailure()
                                    }

                                    File(path, fileName).let {
                                        callback.onSuccess(it.absolutePath)
                                    }

                                }
                            })
                    }
                },
                null
            )
        }
    }
}


private fun getOutputFile(path: File, fileName: String): ParcelFileDescriptor {
    if (!path.exists()) {
        path.mkdirs()
    }

    File(path, fileName).let {
        it.createNewFile()
        return ParcelFileDescriptor.open(it, ParcelFileDescriptor.MODE_READ_WRITE)
    }
}
