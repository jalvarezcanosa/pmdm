package com.afundacion.fp.sessions;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class RegisterActivity extends AppCompatActivity {
    private EditText editTextUser;
    private EditText editTextPassword;
    private Button buttonRegister;
    private Context context = this;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_register);

        editTextUser = findViewById(R.id.edit_text_1);
        editTextPassword = findViewById(R.id.edit_text_2);
        buttonRegister = findViewById(R.id.buttoncrear_usuario);

        buttonRegister.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context, "Usuario: " + editTextUser.getText().toString(), Toast.LENGTH_SHORT).show();
            }
        });


    }
}