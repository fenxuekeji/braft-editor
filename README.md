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
