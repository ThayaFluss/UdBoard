# UdBoad: A Virtual BlackBoard

## What's This ? 
VRChatでの利用を想定した, VR空間でも平面的に書ける黒板と備品(チョーク, 黒板消し, カラーピッカー等）のセットです. 早く書いても複数ユーザー間で同期します. 
-  参考VRChat World: https://vrchat.com/home/world/wrld_d3e2ef84-194f-42c7-9d01-2ae818d49638

## Import 
1. VRCSDKのインポート(VRCSDK2-2020.07.15.12.38_Publicで動作確認)
2. VRChatExample/Prefab2/VRCWorld.prefabをinspectorに配置し, VRCSDKのコントロールパネルにて, レイヤーとcollison matrixの自動セットアップ
3. virtualBB.unitypackageをインポート
4. Scenes/justBBを開く
5. Window -> Rendering -> lighting setup でベイク（これをしないと, 黒板のマテリアル変更をしたときに遠近感が捉えられなくなります.）

## Components
1. WideBoardV4.prefab : 黒板本体
2. ColorPicker.prefab: チョークの色をリアルタイムに変更するためのカラーピッカー
3. R-ChalkV4.prefab: 滑らかな書き味のチョーク 
4. R-ChalkV4Variable.prefab: カラーピッカーに反応するR-Chalk
5. S-ChalkV4.prefab: 鋭い書き味のチョーク 
6. S-ChalkV4Variable.prefab:　カラーピッカーに反応するS-Chalk
7. R-Eraser.prefab: 黒板消し
8. PadVket.prefab: Pickupできる黒板. Pickupと持っている時の動作はVket仕様. 離して30秒で元の位置に戻ってしまうのを回避するには, ResetPositionのAnimatorを無効可すればよい.

## How to use
- 黒板の前（白い境界枠より黒板に近いところ）に立って, チョークを握り込むと書けます. 
現実のように黒板にチョークを接しながら書くこともできます. 
- 黒板に書いたチョークを消す際は, 上下の白いスイッチをtriggerすると対応する黒板の1/4部分が洗われます.  左右のスイッチをtriggerすると全体を洗います. 
- 右にある小さな黒板はスクリーンショット用です. 小さな黒板をtriggerすることで, 自身と上部のスクリーンに現在の黒板の状態が保存されます. 小さな黒板にVRCのカメラを近づけて撮影してください. カメラのほうを自動で向くようになっています. 小さな黒板をtriggerすることで, 上部のスクリーンに現在の黒板の状態が保存されます. 
- 黒板の左にあるマテリアルの形をしたスイッチをtriggerするとFlusher(黒板を洗うもの)のマテリアルが変更されます.  Lightmapのベイクをしていれば, skyboxか黒板の２種類に変更できます. 変更後, Flusherのスイッチで黒板を洗うことで, 黒板の背景を変更できます. 

## Tuning
- 黒板に写す物体の調整:　以下のLayerを同じものにする. ただし、映り込みたくない物体とは異なるLayerを選ぶ. (Default Layerは広く使われており避けるのが無難)
  - WideBoardV4/Cameraのculling mask
  - Flusher/DarkのLayer (他のFlusherも同様)
  - PadVket/ModeController/visual/cameraのculling mask  
  - PadVket/ModeController/visual/Dark
  - S-Chalk/ModeController/visual/trail_pt/trailのLayer
  - R-Chalk/ModeController/visual/trail_pt/trailのLayer
- チョークの書き味・文字の太さの調整
  - R-Chalk/ModeController/visual/trail_pt/trailに使われているmaterialのshaderのパラメータwidthを調整.

## 軽量化
- 動作が重い場合は, WideBoardV4/Screenをnon-activateにしてください. 


## LICENSE
MIT
