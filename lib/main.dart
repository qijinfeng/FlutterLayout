import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Flutter Layout",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.start, //主轴
            crossAxisAlignment: CrossAxisAlignment.center, //交叉轴
            children: <Widget>[
              new MyAppBar(
                title: new Text(
                  'Flutter Layout',
                  style: Theme
                      .of(context)
                      .primaryTextTheme
                      .title,
                ),
              ),
              new Expanded(
                child: new ListView(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true, //内容适配
                  children: [
                    new Image.asset(
                      'images/lake.jpg',
                      width: 600.0,
                      height: 240.0,
                      fit: BoxFit.cover,
                    ),
                    new TitleSectionWidget(),
                    new ButtonSectionWidget(),
                    new TextSectionWidget(),
                    new TapRow(),
                    new FormWidget(),
                    new CounterSimple(),
                    new Counter(),
                    new ShoppingList(
                      products: <Product>[
                        new Product(name: 'Eggs'),
                        new Product(name: 'Flour'),
                        new Product(name: 'Chocolate chips'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}


class MyAppBar extends StatelessWidget {
  MyAppBar({Key key, this.title}) :super(key: key);

  // Widget子类中的字段往往都会定义为"final"

  final Widget title;

  @override
  Widget build(BuildContext context) {
    return new Container(
//      height: 60.0,  //单位是逻辑上的像素（并非真实的像素，类似于浏览器中的像素）
      padding: const EdgeInsets.only(top: 20,),
      margin: const EdgeInsets.all(0),
      decoration: new BoxDecoration(color: Colors.blue[500]),
      // Row 是水平方向的线性布局（linear layout）
      child: new Row(
        //列表项的类型是 <Widget>
        children: <Widget>[
          new IconButton(
            icon: new Icon(Icons.menu, color: Colors.black54,),
            tooltip: 'Navigation menu',
            onPressed: null, // null 会禁用 button
          ),
          // Expanded expands its child to fill the available space.
          new Expanded(
            child: Center(child: title,),
          ),
          new IconButton(
            icon: new Icon(Icons.search, color: Colors.black54,),
            tooltip: 'Search',
            onPressed: null,
          ),
        ],
      ),
    );
  }
}


class TitleSectionWidget extends StatelessWidget {
  TitleSectionWidget({Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(
          top: 32.0, left: 15, right: 15, bottom: 32),
      child: new Row(
        children: [
          new Expanded(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Container(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: new Text(
                    'Oeschinen Lake Campground dahjsg d a adjskha ajkdha akjdha akdsha akdsjha askdja dalisdj adkjal ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                new Text(
                  'Kandersteg, Switzerland',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: new TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          new FavoriteWidget(),
        ],
      ),
    );
  }
}

class ButtonSectionWidget extends StatelessWidget {
  ButtonSectionWidget({Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButtonColumn(context, Icons.call, 'CALL'),
          buildButtonColumn(context, Icons.near_me, 'ROUTE'),
          buildButtonColumn(context, Icons.share, 'SHARE'),
        ],
      ),
    );
  }

  Column buildButtonColumn(BuildContext context, IconData icon, String label) {
    Color color = Theme
        .of(context)
        .primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}


class TextSectionWidget extends StatelessWidget {
  TextSectionWidget({Key key}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.only(
          top: 32.0, left: 15.0, right: 15.0, bottom: 15),
      child: new Text(
        '''Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps.Situated 1,578 meters above sea level,it is one of the larger Alpine Lakes.A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest,leads you to the lake,which warms to 20 degrees Celsius in the summer.Activities enjoyed here include rowing, and riding the summer toboggan run.''',
        softWrap: true,
      ),
    );
  }
}


///有状态的widget,点击改变数量
class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key key}) :super(key: key);

  @override
  _FavoriteWidgetState createState() => new _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorite = true;
  int _favoriteCount = 4000001;

  void _toggleFavorite() {
    setState(() {
      // If the lake is currently favorited, unfavorite it.
      if (_isFavorite) {
        _favoriteCount -= 1;
        _isFavorite = false;
        // Otherwise, favorite it.
      } else {
        _favoriteCount += 1;
        _isFavorite = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        new Container(
          padding: new EdgeInsets.all(0.0),
          child: new IconButton(
            icon: (_isFavorite
                ? new Icon(Icons.star)
                : new Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        new SizedBox(
          width: 30,
          child: new Container(
            child: new Text(
              '$_favoriteCount',
              softWrap: false,
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                  fontStyle: FontStyle.normal, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ],
    );
  }
}


//-----------------------------Tap----------------------------------

class TapRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new TapBoxA(),
          new TapBParentWidget(),
          new TapCParentWidget()
        ],
      ),
    );
  }
}

// TapBoxA 管理自身状态.

//------------------------- TapBoxA ----------------------------------
class TapBoxA extends StatefulWidget {

  TapBoxA({Key key}) : super(key: key);

  @override
  _TapBoxAState createState() => new _TapBoxAState();
}


class _TapBoxAState extends State<TapBoxA> {

  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap, //点击回调
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
        width: 80,
        height: 80,
        decoration: new BoxDecoration(
          //borderRadius: new BorderRadius.circular(20),
          border: new Border.all(color: Color(0xFFFF0000), width: 1),
          borderRadius: const BorderRadius.all(Radius.elliptical(10, 10)),
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
          // 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
          boxShadow: [
            BoxShadow(color: Color(0x99000000),
                offset: Offset(0, 0),
                //offset-x横向阴影的大小，正值阴影在右边，负值阴影在左边，0的时候阴影中盒子后面，看不见的，如果有blur-radius值会有模糊效果。offset-y,纵向阴影的大小
                blurRadius: 2.0,
                //阴影的模糊程度，值越大，阴影越模糊
                spreadRadius: 1.0), //阴影的扩大缩小，正值时，阴影扩大；负值时，阴影缩小，默认为0，和盒子同样大
          ],
        ),
      ),
    );
  }
}

//------------------------- TapBoxB ----------------------------------

//------------------------ TapBParentWidget为 TapBoxB 管理状态.---------

class TapBParentWidget extends StatefulWidget {
  @override
  _TapBParentWidgetState createState() => new _TapBParentWidgetState();
}

class _TapBParentWidgetState extends State<TapBParentWidget> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapBoxB(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class TapBoxB extends StatelessWidget {
  //@required必填参数，要使用@required注解，需要导入foundation library（该库重新导出Dart的meta.dart）
  // 'package: flutter/foundation.dart';
  TapBoxB({
    Key key,
    this.active: false,
    @required this.onChanged
  }) : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged; //一个方法

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ),
        width: 80.0,
        height: 80.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}


//----------------------------- TapBoxC ------------------------------
//---TapCParentWidget与TapBoxC混合管理状态，点击切换状态，按下显示一个绿色边框，松开不可见

class TapCParentWidget extends StatefulWidget {
  @override
  _TapCParentWidgetState createState() => new _TapCParentWidgetState();
}

class _TapCParentWidgetState extends State<TapCParentWidget> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapBoxC(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class TapBoxC extends StatefulWidget {

  TapBoxC({
    Key key,
    this.active: false,
    @required this.onChanged
  }) :super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapBoxCState createState() => new _TapBoxCState();
}

class _TapBoxCState extends State<TapBoxC> {

  bool _highlight = false;

  //按下
  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  //松开
  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  //点击
  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // This example adds a green border on tap down.
    // On tap up, the square changes to the opposite state.
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      //onTapDown之后
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      //onTapDown之后
      child: new Container(
        child: new Center(
          child: new Text(widget.active ? 'Active' : 'Inactive',
              style: new TextStyle(fontSize: 16.0, color: Colors.white)),
        ),
        width: 80.0,
        height: 80.0,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? new Border.all(
            color: Colors.teal[700], width: 10.0,) : null,
        ),
      ),
    );
  }
}


//------------------------From------------------
class FormWidget extends StatefulWidget {
  FormWidget({Key key}) :super(key: key);

  @override
  _FormWidgetState createState() => new _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return
      new Container(
        decoration: new BoxDecoration(
            color: Colors.redAccent
        ),
        margin: const EdgeInsets.all(16),
        child: new Form(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ), new Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: new RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {

                    }
                  },
                  child: Text('submit'),
                ),
              )
            ],
          ),
        ),
      );
  }
}

class CounterSimple extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new _CounterSimpleState();
  }
}


class _CounterSimpleState extends State<CounterSimple> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text('simple'),
          new RaisedButton(
            onPressed: _increment,
            child: new Text('Increment'),
          ),
          new Text('Counter:$_counter')
        ],
      ),
    );
  }
}


class CounterDisplay extends StatelessWidget {
  CounterDisplay({
    Key key,
    this.count
  }) :super(key: key);

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrement extends StatelessWidget {
  CounterIncrement({
    Key key,
    @required this.onPressed
  }) :super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
      onPressed: onPressed,
      child: new Text('Increment'),
    );
  }
}

//------在Flutter中，事件流是“向上”传递的，而状态流是“向下”传递的------------------
//更改计数器（CounterIncrement）向上传递事件，修改_counter,状态改变向下传递，显示 计数器（CounterDisplay）更改显示
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => new _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      ++_counter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Text('difficulty'),
          new CounterIncrement(onPressed: _increment,),
          new CounterDisplay(count: _counter,)
        ],
      ),
    );
  }
}

//const关键字不可修改且必须初始化
class Product {
  const Product({this.name});

  final String name;
}

typedef void CartChangedCallback(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    Product product,
    this.inCart,
    this.onCartChanged
  })
      : product = product,
        super(key: new ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    return inCart ? Colors.black54 : Theme
        .of(context)
        .primaryColor;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (!inCart) return null;
    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        onCartChanged(product, !inCart);
      },
      leading: new CircleAvatar(
        backgroundColor: _getColor(context),
        child: new Text(product.name[0]),
      ),
      title: new Text(product.name, style: _getTextStyle(context)),
    );
  }
}

class ShoppingList extends StatefulWidget {
  ShoppingList({
    Key key,
    this.products
  }) : super(key: key);

  final List<Product> products;

  @override
  _ShoppingListState createState() => new _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  Set<Product> _shoppingCart = new Set<Product>();

  void _handleCartChanged(Product product, bool inCart) {
    setState(() {
      if (inCart)
        _shoppingCart.add(product);
      else
        _shoppingCart.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new ListView(
        shrinkWrap: true, //解决无限高度问题
        physics: new NeverScrollableScrollPhysics(), //禁用滑动事件
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: widget.products.map((Product product) {
          return new ShoppingListItem(
            product: product,
            inCart: _shoppingCart.contains(product),
            onCartChanged: _handleCartChanged,
          );
        }).toList(),
      ),
    );
  }
}
