package com.mix1009.dropbox;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Handler;
import android.os.Looper;
import android.os.StrictMode;
import android.util.Log;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.dropbox.core.DbxAppInfo;
import com.dropbox.core.json.JsonReadException;
import com.dropbox.core.DbxAuthFinish;
import com.dropbox.core.DbxDownloader;
import com.dropbox.core.oauth.DbxCredential;
import com.dropbox.core.DbxException;
import com.dropbox.core.DbxRequestConfig;
import com.dropbox.core.DbxWebAuth;
import com.dropbox.core.android.Auth;
import com.dropbox.core.android.AuthActivity;
import com.dropbox.core.util.IOUtil;
import com.dropbox.core.v2.DbxClientV2;
import com.dropbox.core.v2.auth.DbxUserAuthRequests;
import com.dropbox.core.v2.files.DownloadBuilder;
import com.dropbox.core.v2.files.FileMetadata;
import com.dropbox.core.v2.files.FolderMetadata;
import com.dropbox.core.v2.files.GetTemporaryLinkResult;
import com.dropbox.core.v2.files.ListFolderResult;
import com.dropbox.core.v2.files.MediaInfo;
import com.dropbox.core.v2.files.MediaMetadata;
import com.dropbox.core.v2.files.Metadata;
import com.dropbox.core.v2.files.UploadBuilder;
import com.dropbox.core.v2.files.WriteMode;
import com.dropbox.core.v2.users.FullAccount;
import com.dropbox.core.http.OkHttp3Requestor;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/** DropboxPlugin */
public class DropboxPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {
  private static final String CHANNEL_NAME = "dropbox";
  private static Activity activity;
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    setupChannel(binding.getFlutterEngine().getDartExecutor(), binding.getApplicationContext());
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    teardownChannel();
  }


  public static void registerWith(Registrar registrar) {
    if (registrar.activity() != null) {
      DropboxPlugin.activity = registrar.activity();
    }
    DropboxPlugin plugin = new DropboxPlugin();
    plugin.setupChannel(registrar.messenger(), registrar.context());
  }

  private void setupChannel(BinaryMessenger messenger, Context context) {
    channel = new MethodChannel(messenger, CHANNEL_NAME);
    channel.setMethodCallHandler(this);
  }

  private void teardownChannel() {
    channel.setMethodCallHandler(null);
    channel = null;
  }

  @Override
  public void onAttachedToActivity(ActivityPluginBinding binding)
  {
    DropboxPlugin.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    DropboxPlugin.activity = null;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(ActivityPluginBinding binding) {
    DropboxPlugin.activity = binding.getActivity();
  }

  @Override
  public void onDetachedFromActivity() {
    DropboxPlugin.activity = null;
  }

  protected static DbxRequestConfig sDbxRequestConfig;
  protected static DbxClientV2 client;
  protected static DbxWebAuth webAuth;
  protected static String accessToken;
  protected static DbxCredential credentials;
  protected static String clientId;
  protected static DbxAppInfo appInfo;

  boolean checkClient(Result result) {
    if (client == null) {
      String authToken = Auth.getOAuth2Token();

      if (authToken != null) {
        sDbxRequestConfig = DbxRequestConfig.newBuilder(this.clientId)
                .withHttpRequestor(new OkHttp3Requestor(OkHttp3Requestor.defaultOkHttpClient()))
                .build();

        client = new DbxClientV2(sDbxRequestConfig, authToken);

        this.accessToken = authToken;
        return true;
      }
      result.error("error", "client not logged in", null);
      return false;
    }
    return true;
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("init")) {
      String clientId = call.argument("clientId");
      String key = call.argument("key");
      String secret = call.argument("secret");
      this.clientId = clientId;
      this.appInfo = new DbxAppInfo(key, secret);

      sDbxRequestConfig = DbxRequestConfig.newBuilder(clientId)
              .withHttpRequestor(new OkHttp3Requestor(OkHttp3Requestor.defaultOkHttpClient()))
              .build();

      result.success(true);

    } else if (call.method.equals("authorizePKCE")) {
      sDbxRequestConfig = DbxRequestConfig.newBuilder(this.clientId)
              .withHttpRequestor(new OkHttp3Requestor(OkHttp3Requestor.defaultOkHttpClient()))
              .build();
      Auth.startOAuth2PKCE(DropboxPlugin.activity , appInfo.getKey(),sDbxRequestConfig);
      result.success(true);

    } else if (call.method.equals("authorize")) {
      Auth.startOAuth2Authentication(DropboxPlugin.activity , appInfo.getKey());
      result.success(true);

    } else if (call.method.equals("authorizeWithAccessToken")) {
      String argAccessToken = call.argument("accessToken");

      sDbxRequestConfig = DbxRequestConfig.newBuilder(this.clientId)
              .withHttpRequestor(new OkHttp3Requestor(OkHttp3Requestor.defaultOkHttpClient()))
              .build();

      client = new DbxClientV2(sDbxRequestConfig, argAccessToken);

      this.accessToken = argAccessToken;
      result.success(true);

    } else if (call.method.equals("authorizeWithCredentials")) {
      String argCredentials = call.argument("credentials");
      // now de-serialize credentials
      sDbxRequestConfig = DbxRequestConfig.newBuilder(this.clientId)
              .withHttpRequestor(new OkHttp3Requestor(OkHttp3Requestor.defaultOkHttpClient()))
              .build();
      DbxCredential creds;
       try {
         creds = DbxCredential.Reader.readFully(argCredentials);
         client = new DbxClientV2(sDbxRequestConfig, creds);
       } catch (JsonReadException e) {
         throw new IllegalStateException("Credential data corrupted: " + e.getMessage());
       }    

      this.credentials = creds;
      result.success(true);

    } else if (call.method.equals("getAuthorizeUrl")) {

      if (webAuth == null) {
        webAuth = new DbxWebAuth(sDbxRequestConfig, appInfo);
      }

      DbxWebAuth.Request webAuthRequest = DbxWebAuth.newRequestBuilder()
              .withNoRedirect()
              .build();

      String authorizeUrl = webAuth.authorize(webAuthRequest);
      result.success(authorizeUrl);

    } else if (call.method.equals("unlink")) {
      client = null;
      accessToken = null;
      AuthActivity.result = null;
      // call DbxUserAuthRequests.tokenRevoke(); ?

    } else if (call.method.equals("finishAuth")) {
      String code = call.argument("code");
      (new FinishAuthTask(webAuth, result, code)).execute("");


    } else if (call.method.equals("getAccountName")) {

      if (!checkClient(result)) return;
      (new GetAccountNameTask(result)).execute("");

    } else if (call.method.equals("listFolder")) {
      String path = call.argument("path");

      if (!checkClient(result)) return;
      (new ListFolderTask(result)).execute(path);

    } else if (call.method.equals("getTemporaryLink")) {
      String path = call.argument("path");

      if (!checkClient(result)) return;
      (new TemporaryLinkTask(result)).execute(path);
    } else if (call.method.equals("getThumbnailBase64String")) {
      String path = call.argument("path");

      if (!checkClient(result)) return;
      (new ThumbnailBase64StringTask(result)).execute(path);
    } else if (call.method.equals("getAccessToken")) {
//      result.success(accessToken);
      String token = Auth.getOAuth2Token();
      if (token == null) {
        token = this.accessToken;
      }
      result.success(token);
    } else if (call.method.equals("getCredentials")) {
      DbxCredential myCred = Auth.getDbxCredential();
      if (myCred == null) {
        myCred = this.credentials;
      }
      String credString = myCred != null ? myCred.toString() : null;
      result.success(credString);

    } else if (call.method.equals("upload")) {
      String filepath = call.argument("filepath");
      String dropboxpath = call.argument("dropboxpath");
      int key = call.argument("key");

      if (!checkClient(result)) return;
      (new UploadTask(channel, key, result)).execute(filepath, dropboxpath);

    } else if (call.method.equals("download")) {
      String filepath = call.argument("filepath");
      String dropboxpath = call.argument("dropboxpath");
      int key = call.argument("key");

      if (!checkClient(result)) return;
      (new DownloadTask(channel, key, result)).execute(dropboxpath, filepath);

    } else {
      result.notImplemented();
    }
  }

  class FinishAuthTask extends AsyncTask<String, Void, String> {
    DbxWebAuth webAuth;
    Result result;
    String code;

    private FinishAuthTask(DbxWebAuth _webAuth, Result _result, String _code) {
      webAuth = _webAuth;
      result = _result;
      code = _code;
    }
    @Override
    protected String doInBackground(String... urls) {

      DbxAuthFinish authFinish;
      try {
        authFinish = webAuth.finishFromCode(code);
      } catch (DbxException ex) {
        System.err.println("Error in DbxWebAuth.authorize: " + ex.getMessage());
        return "";
      }

      String accessToken = authFinish.getAccessToken();

      DropboxPlugin.client = new DbxClientV2(DropboxPlugin.sDbxRequestConfig, accessToken);
      DropboxPlugin.accessToken = accessToken;

      return accessToken;
  }

    @Override
    protected void onPostExecute(String r) {
      super.onPostExecute(r);
      result.success(r);
    }
  }

  class GetAccountNameTask extends AsyncTask<String, Void, String> {
    Result result;

    private GetAccountNameTask(Result _result) {
      result = _result;
    }
    @Override
    protected String doInBackground(String... urls) {

      FullAccount account = null;
      try {
        account = DropboxPlugin.client.users().getCurrentAccount();
      } catch (DbxException e) {
        e.printStackTrace();
        return e.getMessage();
      }
      String name = account.getName().getDisplayName();
      return name;
    }

    @Override
    protected void onPostExecute(String r) {
      super.onPostExecute(r);
      result.success(r);
    }
  }

  class ListFolderTask extends AsyncTask<String, Void, String> {
    Result result;
    List<Object> paths = new ArrayList<>();

    private ListFolderTask(Result _result) {
      result = _result;
    }

    @Override
    protected String doInBackground(String... argPaths) {

      ListFolderResult listFolderResult = null;
      try {
        listFolderResult = DropboxPlugin.client.files().listFolder(argPaths[0]);
        String pattern = "yyyyMMdd HHmmss";
        DateFormat df = new SimpleDateFormat(pattern);

        while (true) {

          for (Metadata metadata : listFolderResult.getEntries()) {
            Map<String, Object> map = new HashMap<>();
            map.put("name", metadata.getName());
            map.put("pathLower", metadata.getPathLower());
            map.put("pathDisplay", metadata.getPathDisplay());

            if (metadata instanceof FileMetadata) {
              FileMetadata fileMetadata = (FileMetadata) metadata;
              map.put("filesize", fileMetadata.getSize());
              map.put("clientModified", df.format(fileMetadata.getClientModified()));
              map.put("serverModified", df.format(fileMetadata.getServerModified()));
//            } else if (metadata instanceof FolderMetadata){
//              FolderMetadata folderMetadata = (FolderMetadata) metadata;


            }

            paths.add(map);
//            paths.add(metadata.getPathLower());
          }

          if (!listFolderResult.getHasMore()) {
            break;
          }

          listFolderResult = DropboxPlugin.client.files().listFolderContinue(listFolderResult.getCursor());
        }
      } catch (DbxException e) {
        e.printStackTrace();
        return e.getMessage();
      }

      return "";
    }

    @Override
    protected void onPostExecute(String r) {
      super.onPostExecute(r);
      result.success(paths);
    }

  }

  class TemporaryLinkTask extends AsyncTask<String, Void, String> {
    Result result;

    private TemporaryLinkTask(Result _result) {
      result = _result;
    }
    @Override
    protected String doInBackground(String... argPaths) {

      GetTemporaryLinkResult linkResult = null;
      try {
        linkResult = DropboxPlugin.client.files().getTemporaryLink(argPaths[0]);

        String link = linkResult.getLink();

        return link;
      } catch (DbxException e) {
        e.printStackTrace();
        return e.getMessage();
      }
    }
    @Override
    protected void onPostExecute(String r) {
      super.onPostExecute(r);
      result.success(r);
    }
  }

  class ThumbnailBase64StringTask extends AsyncTask<String, Void, String> {
    Result result;

    private ThumbnailBase64StringTask(Result _result) {
      result = _result;
    }
    @Override
    protected String doInBackground(String... argPaths) {
      try {
        String path = argPaths[0];
        DbxDownloader<FileMetadata> downloader = DropboxPlugin.client.files().getThumbnail(path);
        ByteArrayOutputStream bo = new ByteArrayOutputStream();
        downloader.download(bo);
        String encodedString = Base64.getEncoder().encodeToString(bo.toByteArray());

        return encodedString;
      } catch (DbxException e) {
        e.printStackTrace();
        return e.getMessage();
      } catch (IOException e) {
        e.printStackTrace();
        return e.getMessage();
      }
    }
    @Override
    protected void onPostExecute(String r) {
      super.onPostExecute(r);
      result.success(r);
    }
  }

  class UploadTask extends AsyncTask<String, Void, String> {
    Result result;
    int key;
    MethodChannel channel;
    List<Object> paths = new ArrayList<>();

    private UploadTask(MethodChannel _channel, int _key, Result _result) {
      channel = _channel;
      key = _key;
      result = _result;
    }

    @Override
    protected String doInBackground(String... argPaths) {

      UploadBuilder uploadBuilder = null;
        try {
          InputStream in = new FileInputStream(argPaths[0]);

          uploadBuilder = DropboxPlugin.client.files().uploadBuilder(argPaths[1]).withMode(WriteMode.OVERWRITE).withAutorename(true).withMute(false);

          uploadBuilder.uploadAndFinish(in, new IOUtil.ProgressListener() {
            @Override
            public void onProgress(long bytesWritten) {
              final long written = bytesWritten;
              new Handler(Looper.getMainLooper()).post(new Runnable () {
                @Override
                public void run () {
                  // MUST RUN ON MAIN THREAD !
                  List<Long> ret = new ArrayList<Long>();
                  ret.add((long)key);
                  ret.add(written);
                  channel.invokeMethod("progress", ret, null);
                }
              });

            }
          });

        } catch (FileNotFoundException e) {
          e.printStackTrace();
          return e.getMessage();
        } catch (IOException e) {
          e.printStackTrace();
        } catch (DbxException e) {
        e.printStackTrace();
        return e.getMessage();
        }

      return "";
    }

    @Override
    protected void onPostExecute(String r) {
      super.onPostExecute(r);
      result.success(paths);
    }

  }

  class DownloadTask extends AsyncTask<String, Void, String> {
    Result result;
    int key;
    long fileSize;
    MethodChannel channel;
    List<Object> paths = new ArrayList<>();

    private DownloadTask(MethodChannel _channel, int _key, Result _result) {
      channel = _channel;
      key = _key;
      result = _result;
    }

    @Override
    protected String doInBackground(String... argPaths) {

      try {
        fileSize = 0;
        Metadata metadata = client.files().getMetadata(argPaths[0]);

        if (metadata instanceof FileMetadata) {
          FileMetadata fileMetadata = (FileMetadata) metadata;
          fileSize = fileMetadata.getSize();
        }

        DbxDownloader<FileMetadata> downloader = client.files().download(argPaths[0]);
        OutputStream out = new FileOutputStream(argPaths[1]);
        downloader.download(out, new IOUtil.ProgressListener() {
          @Override
          public void onProgress(long bytesRead) {
            final long read = bytesRead;
            new Handler(Looper.getMainLooper()).post(new Runnable () {
              @Override
              public void run () {
                // MUST RUN ON MAIN THREAD !
                List<Long> ret = new ArrayList<Long>();
                ret.add((long)key);
                ret.add(read);
                ret.add(fileSize);
                channel.invokeMethod("progress", ret, null);
              }
            });

          }
        });

      } catch (FileNotFoundException e) {
        e.printStackTrace();
        return e.getMessage();

      } catch (IOException e) {
        e.printStackTrace();
      } catch (DbxException e) {
        e.printStackTrace();
        return e.getMessage();
      }

      return "";
    }

      @Override
    protected void onPostExecute(String r) {
      super.onPostExecute(r);
      result.success(paths);
    }

  }
}

