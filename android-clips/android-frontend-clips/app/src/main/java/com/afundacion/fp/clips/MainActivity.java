package com.afundacion.fp.clips;

import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.ProgressBar;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonArrayRequest;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;
import com.google.android.material.snackbar.Snackbar;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class MainActivity extends AppCompatActivity {
    private RequestQueue queue;
    private Context context = this;
    private ConstraintLayout mainLayout;
    private ProgressBar progressBar;
    private ClipsList clips;

    public void setClips(ClipsList clips) {
        this.clips = clips;
    }

    public ClipsList getClipsForTest() {
        return clips;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        this.queue = Volley.newRequestQueue(context);
        this.mainLayout = findViewById(R.id.main_layout);
        this.progressBar =  findViewById(R.id.progress_circular);

        getClipList();

        JsonObjectRequest request = new JsonObjectRequest(
                Request.Method.GET,
                Server.name + "/health2",
                null,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {

                        try {
                            Toast.makeText(MainActivity.this, "Hit OK: " + response.getString("status"), Toast.LENGTH_SHORT).show();
                        } catch (JSONException e) {
                            throw new RuntimeException(e);
                        }
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        if (error.networkResponse == null) {
                            Toast.makeText(context, "Server could not be reached", Toast.LENGTH_SHORT).show();
                        }else {
                            int serverCode = error.networkResponse.statusCode;
                            Toast.makeText(context, "Server replied with " + serverCode, Toast.LENGTH_SHORT).show();
                        }
                    }
                }
        );
        this.queue.add(request);
    }

    private void getClipList() {
        progressBar.setVisibility(View.VISIBLE);
        JsonArrayRequest jsonArrayRequest = new JsonArrayRequest(
                Request.Method.GET,
                Server.name + "/clips",
                null,
                new Response.Listener<JSONArray>() {
                    @Override
                    public void onResponse(JSONArray response) {
                        progressBar.setVisibility(View.INVISIBLE);
                        Snackbar.make(mainLayout, "Clips received", Snackbar.LENGTH_LONG).show();

                        setClips(new ClipsList(response));
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError volleyError) {
                        progressBar.setVisibility(View.INVISIBLE);
                        if (volleyError.networkResponse == null){
                            Snackbar.make(mainLayout, "Server could not be reached", Snackbar.LENGTH_LONG).show();
                        }else {
                            int serverCode = volleyError.networkResponse.statusCode;
                            Snackbar.make(mainLayout, "Server status is " + serverCode, Snackbar.LENGTH_LONG).show();
                        }
                    }
                }

        );
        this.queue.add(jsonArrayRequest);
    }

}

