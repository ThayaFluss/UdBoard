# Virtual BlackBoard

## What's This ? 
VRChatでの利用を想定した, 平面的に書ける黒板と備品(チョーク, 黒板消し, カラーピッカー等）のセットです。

## Import 
1. VRCSDKのインポート(VRCSDK2-2020.07.15.12.38_Publicで動作確認)
2. VRChatExample/Prefab2/VRCWorld.prefabをinspectorに配置し、VRCSDKのコントロールパネルにて、レイヤーとcollison matrixの自動セットアップ
3. virtualBB.unitypackageをインポート
4. Scenses/justBBを開く
5. Window -> Rendering -> lighting setup でベイク（これをしないと、黒板のマテリアル変更をしたときに遠近感が捉えられなくなります。）

## Components
1. WideBoardV4.prefab : 黒板本体
2. ColorPicker.prefab: チョークの色をリアルタイムに変更するためのカラーピッカー
3. R-ChalkV4.prefab: 滑らかな書き味のチョーク 
4. R-ChalkV4Variable.prefab: カラーピッカーに反応するR-Chalk
5. S-ChalkV4.prefab: 鋭い書き味のチョーク 
6. S-ChalkV4Variable.prefab:　カラーピッカーに反応するS-Chalk
7. R-Eraser.prefab: 黒板消し


## How to use
- 黒板の前（白い境界枠より黒板に近いところ）に立って、チョークを握り込むと書けます。
現実のように黒板にチョークを接しながら書くこともできます。
- 黒板を消す際は、上下の白いスイッチをtriggerすると対応する黒板の1/4部分が洗われます。 左右のスイッチをtriggerすると全体を洗います。
- 右にある小さな黒板はスクリーンショット用です。小さな黒板をtriggerすることで、自身と上部のスクリーンに現在の黒板の状態が保存されます。小さな黒板にVRCのカメラを使ずけて撮影ください。カメラのほうを自動で向くようになっています。小さな黒板をtriggerすることで、上部のスクリーンに現在の黒板の状態が保存されます。
- 黒板の左にあるマテリアルの形をしたスイッチをtriggerするとFlusher(黒板を洗うもの)のマテリアルが変更されます。 Lightmapのベイクをしていれば、skyboxか黒板の２種類に変更できます。

## 軽量化
- 動作が重い場合は、WideBoardV4/Screenをnon-activateにしてください。


## LICENSE
MIT
