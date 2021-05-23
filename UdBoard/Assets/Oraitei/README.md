
# Virtual BlackBoard
- Author: かた湯(https://twitter.com/Ka_Ta_Yu)　＠おうらい亭

## What's This ? 
VRChatでの利用を想定した、平面的に書ける黒板、チョーク、黒板消しなどのセットです。

## How to Use
- 黒板の前に立って, チョークを握り込むと書けます. 
現実のように黒板にチョークを接しながら書くこともできます. 
- 黒板に書いたチョークを消す際は, 上下の白いスイッチをtriggerすると対応する黒板の1/4部分が洗われます.  左右のスイッチをtriggerすると全体を洗います. 
- 右にある小さな黒板はスクリーンショット用です. 小さな黒板をtriggerすることで, 自身と上部のスクリーンに現在の黒板の状態が保存されます. 小さな黒板にVRCのカメラを近づけて撮影してください. カメラのほうを自動で向くようになっています. 小さな黒板をtriggerすることで, 上部のスクリーンに現在の黒板の状態が保存されます. 
- 黒板の左にあるマテリアルの形をしたスイッチをtriggerするとFlusher(黒板を洗うもの)のマテリアルが変更されます.  Lightmapのベイクをしていれば, skyboxか黒板の２種類に変更できます. 変更後, Flusherのスイッチで黒板を洗うことで, 黒板の背景を変更できます. 

## Components
1. UdBoard.prefab : 黒板本体
2. ColorPicker.prefab: チョークの色をリアルタイムに変更するためのカラーピッカー
3. R-ChalkSet.prefab: 滑らかな書き味のチョークのセット
4. R-ChalkAAVariable.prefab: カラーピッカーに反応するR-Chalk
5. S-ChalkAA.prefab: 鋭い書き味のチョーク 
6. S-ChalkAAVariable.prefab:　カラーピッカーに反応するS-Chalk
7. R-Eraser.prefab: 黒板消し
8. UdPad.prefab: Pickupできる黒板. 


## How To Import
1. VRCSDK2のインポート
2. VRChatExample/Prefab2/VRCWorld.prefabをinspectorに配置し, VRCSDKのコントロールパネルにて, レイヤーとcollison matrixの自動セットアップ
3. UdBoard.unitypackageをインポート
(Oraitei/Scenes/justBBがサンプル配置です）

## Tuning
- 黒板に写す物体の調整:　以下のLayerを同じものにする. ただし、映り込みたくない物体とは異なるLayerを選ぶ. (Default Layerは避けるのが無難)
  - UdBoard/Cameraのculling mask
  - Flusher/DarkのLayer
  - UdPad/ModeController/visual/cameraのculling mask  
  - UdPad/ModeController/visual/Dark
  - S-Chalk/ModeController/visual/trail_pt/trailのLayer
  - R-Chalk/ModeController/visual/trail_pt/trailのLayer
- チョークの書き味・文字の太さの調整
  - R-Chalk/ModeController/visual/trail_pt/trailに使われているmaterialのshaderのパラメータwidthを調整.

