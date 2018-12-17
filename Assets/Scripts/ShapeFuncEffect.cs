using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ShapeFuncEffect : MonoBehaviour{
public Shader defferedFog;

    
    Material fogMaterial;



    [ImageEffectOpaque]
    private void OnRenderImage(RenderTexture source, RenderTexture destination) {
        if(fogMaterial == null) {
            fogMaterial = new Material(defferedFog);
        }

        Graphics.Blit(source, destination, fogMaterial);
    }
}
