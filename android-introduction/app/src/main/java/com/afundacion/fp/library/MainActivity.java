package com.afundacion.fp.library;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.Button;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toast.makeText(this, "La tostada del desayuno", Toast.LENGTH_SHORT).show();
        ClickHandler myHandler = new ClickHandler(this);
        Button myButton = findViewById(R.id.toastButton);
        myButton.setOnClickListener(myHandler);
    }

}