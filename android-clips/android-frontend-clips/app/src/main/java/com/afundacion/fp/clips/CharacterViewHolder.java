package com.afundacion.fp.clips;

import android.view.View;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class CharacterViewHolder extends RecyclerView.ViewHolder {
    private TextView textView;
    private ImageView characterImageView;


    public CharacterViewHolder(@NonNull View itemView) {
        super(itemView);
        textView = itemView.findViewById(R.id.text_view_character);
        characterImageView = itemView.findViewById(R.id.image_view_character);
    }

    public void showData(Character character) {
        this.textView.setText(character.getName());
        Util.downloadBitmapToImageView(character.getUrlImage(), this.characterImageView);
    }
}

