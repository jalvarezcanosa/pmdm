package com.afundacion.fp.sessions;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONObject;

public class StatusActivity extends AppCompatActivity {
    private Context context = this;
    private RequestQueue queue;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_status);
        // Inicializamos la cola de peticiones y preparamos la petición inicial
        queue = Volley.newRequestQueue(this);
        getUserStatus();
    }

    private void getUserStatus() {
        // Recuperamos el nombre de usuario de las preferencias
        SharedPreferences preferences = getSharedPreferences("SESSIONS_APP_PREFS", MODE_PRIVATE);
        String username = preferences.getString("VALID_USERNAME", null); // null será el valor por defecto
        // Mandaremos la petición GET
        JsonObjectRequest request = new JsonObjectRequest(
                Request.Method.GET,
                Server.name + "/users/" + username + "/status",
                null,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        Toast.makeText(context, "Estado obtenido", Toast.LENGTH_LONG).show();
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Toast.makeText(context, "Estado KO", Toast.LENGTH_LONG).show();
                    }
                }
        );
        queue.add(request);
    }


}