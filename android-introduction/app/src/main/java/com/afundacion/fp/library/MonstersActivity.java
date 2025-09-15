package com.afundacion.fp.library;

import android.content.Context;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationBarView;

public class MonstersActivity extends AppCompatActivity {

    private Context context = this;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_monsters);

        BottomNavigationView bar = findViewById(R.id.bottomNavigation);
        bar.setOnItemSelectedListener(new NavigationBarView.OnItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {
                if (menuItem.getItemId() == R.id.item1){
                    Toast.makeText(context,"Has clicado el Digimon 1", Toast.LENGTH_LONG).show();
                }
                if (menuItem.getItemId() == R.id.item2){
                    Toast.makeText(context, "Este es el segundo Digimon", Toast.LENGTH_LONG).show();
                }
                if (menuItem.getItemId() == R.id.item3){
                    Toast.makeText(context, "Este es el tercer Digimon", Toast.LENGTH_SHORT).show();
                }
                return true;
            }
        });
    }

}
