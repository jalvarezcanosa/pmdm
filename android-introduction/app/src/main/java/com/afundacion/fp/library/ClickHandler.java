package com.afundacion.fp.library;

import android.content.Context;
import android.view.View;
import android.widget.Toast;

public class ClickHandler implements View.OnClickListener {
    private Context context;

    public ClickHandler(Context context) {
        this.context = context;
    }

    @Override
    public void onClick(View view) {
        Toast.makeText(this.context, "¡No te quemes!", Toast.LENGTH_LONG).show();
    }
}
