package com.afundacion.fp.sessions;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.NetworkError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

public class LoginActivity extends AppCompatActivity {
    private Button buttonNoAccount;
    private Button buttonLogin;
    private EditText username;
    private EditText password;
    private RequestQueue requestQueue;
    Context context = this;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

        buttonNoAccount = findViewById(R.id.button_no_cuenta);
        buttonLogin = findViewById(R.id.button_login);
        username = findViewById(R.id.edit_text_user);
        password = findViewById(R.id.edit_text_password);

        requestQueue = Volley.newRequestQueue(this);

        buttonNoAccount.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(LoginActivity.this, RegisterActivity.class);
                startActivity(intent);
            }
        });

        buttonLogin.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                sendPostLogin();
            }
        });
    }

    private void sendPostLogin() {
        JSONObject requestBody = new JSONObject();
        try {
            requestBody.put("username", username.getText().toString());
            requestBody.put("password", password.getText().toString());
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }

        JsonObjectRequest request = new JsonObjectRequest(
                Request.Method.POST,
                Server.name + "/sessions",
                requestBody,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        String receivedToken;
                        try {
                            receivedToken = response.getString("sessionToken");
                        } catch (JSONException e) {
                            throw new RuntimeException(e);
                        }

                        Toast.makeText(context, "Token " + receivedToken, Toast.LENGTH_SHORT).show();

                        SharedPreferences preferences = context.getSharedPreferences("SESSIONS_APP_PREFS", MODE_PRIVATE);
                        SharedPreferences.Editor editor = preferences.edit();
                        editor.putString("VALID_USERNAME", username.getText().toString());
                        editor.putString("VALID_TOKEN", receivedToken);
                        editor.commit();

                        Intent intent = new Intent(LoginActivity.this, StatusActivity.class);
                        startActivity(intent);
                        finish();
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        int statusCode = error.networkResponse.statusCode;
                        Toast.makeText(context, "Código de respuesta: " + statusCode, Toast.LENGTH_LONG).show();
                    }
                }
        );
        this.requestQueue.add(request);
    }
}
