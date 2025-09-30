package com.afundacion.fp.clips;

import android.content.Context;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

public class ClipViewHolder extends RecyclerView.ViewHolder {
    private TextView clipTitle;
    private Clip clip;

    public ClipViewHolder(@NonNull View itemView) {
        super(itemView);
        clipTitle = itemView.findViewById(R.id.text_view);
        itemView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                int clipId = clip.getId();
                Context context = view.getContext();
                Toast.makeText(context, "Touched ViewHolder with clipId: " + clipId, Toast.LENGTH_SHORT).show();
            }
        });

    }

    public void showData(Clip clip) {
        this.clip = clip;
        this.clipTitle.setText(clip.getTitle());
    }

}
