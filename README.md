# Braft Editor添加图片宽高属性

lazyimage图片处理必须知道图片原始大小，本项目在Braft-Editor上修改添加了记录图片原始宽高属性

```
data-origin-width： 图片原始宽度记录
data-origin-height: 图片原始高度记录
```


> 千万不要用 react-lz-editor,这个库对于draft的block解析html混乱，常会出现图片删除不了情况 *


## 修改代码

修改src/configs/convert.js文件

1. convertAtomicBlock函数中，img标签中添加宽高属性
```
<img src={url} data-origin-width={entity.getData()["data-origin-width"]} data-origin-height={entity.getData()["data-origin-height"]} width={width} height={height} style={{width, height}} />
```
2. htmlToEntity函数添加宽高属性

```
 if(node.attributes['data-origin-width'] && node.attributes['data-origin-height']){
      entityData["data-origin-width"]=node.attributes['data-origin-width'].nodeValue;
      entityData["data-origin-height"]=node.attributes['data-origin-height'].nodeValue;
    }
```

## 调用编辑器
```
that.editorInstance.insertMedias(Objects)
```
在Objects参数中添加 {"data-origin-width": "xxx","data-origin-height": "xxx"}属性

![图片说明1](http://o6sfjf3zh.bkt.clouddn.com/E5A9226D-24F6-4269-A029-7193C93CB60F.png?imageView/2/w/619)


# 修改2：新增视频/音频 文件大小
修改文件：
1. src/configs/convert.js
```
Index: src/configs/convert.js
IDEA additional info:
Subsystem: com.intellij.openapi.diff.impl.patch.CharsetEP
<+>UTF-8
===================================================================
--- src/configs/convert.js	(revision f09e2635a7ae8990361ca4297f12c345219552fc)
+++ src/configs/convert.js	(revision )
@@ -47,9 +47,9 @@
     }
 
   } else if (mediaType === 'audio') {
-    return <div className="media-wrap audio-wrap"><audio controls src={url} /></div>
+    return <div className="media-wrap audio-wrap"><audio controls src={url} data-file-size={entity.getData()["data-file-size"]}/></div>
   } else if (mediaType === 'video') {
-    return <div className="media-wrap video-wrap"><video controls src={url} width={width} height={height} /></div>
+    return <div className="media-wrap video-wrap"><video controls src={url} width={width} height={height} data-file-size={entity.getData()["data-file-size"]}/></div>
   } else if (mediaType === 'hr') {
     return <hr></hr>
   } else {
@@ -217,9 +217,9 @@
     let { href, target } = node
     return createEntity('LINK', 'MUTABLE',{ href, target })
   } else if (nodeName === 'audio') {
-    return createEntity('AUDIO', 'IMMUTABLE',{ url: node.src })
+    return createEntity('AUDIO', 'IMMUTABLE',{ url: node.src , 'data-file-size': node.attributes['data-file-size'].nodeValue })
   } else if (nodeName === 'video') {
-    return createEntity('VIDEO', 'IMMUTABLE',{ url: node.src })
+    return createEntity('VIDEO', 'IMMUTABLE',{ url: node.src , 'data-file-size': node.attributes['data-file-size'].nodeValue })
   } else if (nodeName === 'img') {
 
     let parentNode = node.parentNode

```
2. src/controller/index.js
```
Index: src/controller/index.js
IDEA additional info:
Subsystem: com.intellij.openapi.diff.impl.patch.CharsetEP
<+>UTF-8
===================================================================
--- src/controller/index.js	(revision f09e2635a7ae8990361ca4297f12c345219552fc)
+++ src/controller/index.js	(revision )
@@ -245,6 +245,7 @@
                 name,
                 type,
                 meta,
+                "data-file-size": media['data-file-size'],
                 "data-origin-width": media['data-origin-width'],
                 "data-origin-height": media['data-origin-height'],
             })

```