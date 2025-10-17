package com.afundacion.fp.sessions;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.JsonObjectRequest;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

public class RegisterActivity extends AppCompatActivity {
    private EditText editTextUser;
    private EditText editTextPassword;
    private Button buttonRegister;
    private Context context = this;
    private RequestQueue requestQueue;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        editTextUser = findViewById(R.id.edit_text_1);
        editTextPassword = findViewById(R.id.edit_text_2);
        buttonRegister = findViewById(R.id.button_crear_usuario);

        buttonRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context, "Usuario: " + editTextUser.getText().toString(), Toast.LENGTH_SHORT).show();

                sendPostRequest();
            }
        });

        requestQueue = Volley.newRequestQueue(this);
        
    }

    private void sendPostRequest(){
        JSONObject requestBody = new JSONObject();
        try {
            requestBody.put("username", editTextUser.getText().toString());
            requestBody.put("password", editTextPassword.getText().toString());
        } catch (JSONException e) {
            throw new RuntimeException(e);
        }

        JsonObjectRequest request = new JsonObjectRequest(
                Request.Method.POST,
                Server.name + "/users",
                requestBody,
                new Response.Listener<JSONObject>() {
                    @Override
                    public void onResponse(JSONObject response) {
                        Toast.makeText(context, "Cuenta creada con éxito", Toast.LENGTH_LONG).show();
                        finish();
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        if (error.networkResponse == null) {
                            Toast.makeText(context, "La conexión no se ha establecido", Toast.LENGTH_LONG).show();
                        }else{
                            int serverCode = error.networkResponse.statusCode;

                            Toast.makeText(context, "Código de respuesta: "+ serverCode, Toast.LENGTH_LONG).show();
                        }
                    }
                }
        );
        this.requestQueue.add(request);
    }

}