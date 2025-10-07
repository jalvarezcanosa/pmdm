package com.afundacion.fp.clips;

import com.android.volley.toolbox.JsonArrayRequest;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.List;

public class CharactersList {
    private List<Character> characters;

    public List<Character> getCharacters() {
        return characters;
    }

    public CharactersList(JSONArray jsonArray) throws JSONException {
        characters = new ArrayList<>();
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            Character character = new Character(jsonObject); //lo transformas a character con el constructor creado antes
            characters.add(character);
        }
    }
}
