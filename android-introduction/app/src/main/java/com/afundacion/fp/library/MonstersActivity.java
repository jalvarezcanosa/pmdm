package com.afundacion.fp.library;

import android.content.Context;
import android.os.Bundle;
import android.view.MenuItem;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;

import com.google.android.material.bottomnavigation.BottomNavigationView;
import com.google.android.material.navigation.NavigationBarView;

public class MonstersActivity extends AppCompatActivity {

    private Context context = this;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_monsters);

        getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, new Fragment1()).commit();

        BottomNavigationView bar = findViewById(R.id.bottomNavigation);
        bar.setOnItemSelectedListener(new NavigationBarView.OnItemSelectedListener() {
            @Override
            public boolean onNavigationItemSelected(@NonNull MenuItem menuItem) {
                if (menuItem.getItemId() == R.id.item1){
                    Toast.makeText(context,"Has clicado en Digimon 1", Toast.LENGTH_LONG).show();
                    Fragment myFragment = new Fragment1();
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, myFragment).commit();

                }
                if (menuItem.getItemId() == R.id.item2){
                    Toast.makeText(context, "Este es el segundo Digimon", Toast.LENGTH_LONG).show();
                    Fragment myFragment2 = new Fragment2();
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, myFragment2).commit();
                }
                if (menuItem.getItemId() == R.id.item3){
                    Toast.makeText(context, "Este es el tercer Digimon", Toast.LENGTH_SHORT).show();
                    Fragment myFragment3= new Fragment3();
                    getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, myFragment3).commit();
                }
                return true;
            }
        });
    }

}
