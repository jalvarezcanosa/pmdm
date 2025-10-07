package com.afundacion.fp.clips;

import org.json.JSONException;
import org.json.JSONObject;

public class Character {
    private String name;
    private String lastName;
    private String characterDescription;
    private String urlImage;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getCharacterDescription() {
        return characterDescription;
    }

    public void setCharacterDescription(String characterDescription) {
        this.characterDescription = characterDescription;
    }

    public String getUrlImage() {
        return urlImage;
    }

    public void setUrlImage(String urlImage) {
        this.urlImage = urlImage;
    }

    public Character(JSONObject jsonObject) throws JSONException {
        this.name = jsonObject.getString("name");
        this.lastName = jsonObject.getString("surname");
        this.characterDescription = jsonObject.getString("description");
        this.urlImage = jsonObject.getString("imageUrl");
    }
}
