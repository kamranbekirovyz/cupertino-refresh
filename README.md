
# cupertino_refresh

iOS-styled refresh control Widget and Sliver for Flutter.

<img src="https://raw.githubusercontent.com/porelarte/cupertino-refresh/master/.docs/cover.png" alt="cover_picture" />

## 🚀 Motivation

While developing one of my client's mobile application I felt a need for a UI component for the purpose that whenever a user wants to refresh the page, he/she should be able to trigger an all-over start for the page's data instead of going back and renavigating. By using `RefreshIndicator` which is included in the `material` package of Flutter the mission was achieved. But, it was, seemingly, exotic on iOS devices. I felt a need, the need for an iOS-styled refresh control, which turned out to be included in the `cupertino` package of Flutter as `CupertinoRefreshSliver`.

So, why package then? 🤔

You see, `CupertinoRefreshSliver` is a sliver which means in order to be able to use it you have to use `CustomScrollView` to layout your widgets and `Sliver`s for everything, although, if not for everything but at least with refactoring and wrapping widgets inside `SliverToBoxAdapter`, yet, always, `Sliver`s are there. But who wants to refactor every view just to have iOS-styled refresh control? I didn't, so I've created a workaround which I call: the `CupertinoRefresh` widget.

PS: If you're already using `CustomScrollView` for the layout you can use `CupertinoRefreshSliver` directly as the first element of your `Sliver`s list. See the example below.

## 🕹️ Usage

There are two types of refresh control as mentioned above:
1. `CupertinoRefresh`: a widget that can wrap any other widget.
2. `CupertinoRefreshSliver`: a Sliver that can be used in combination with Slivers (w/ `CustomScrollView`).

#### 1. `CupertinoRefresh`

```dart
...
CupertinoRefresh.withScrollbar(
  onRefresh: () {
    return _fetchData();
  },

  // The child of [CupertinoRefresh] widget must not be necessarily a
  // scrollable widget as it can be any widget

  child:  Column(
    children: [
    
      // While using with [SingleChildScrollView] is seamless,
      // [ListView] has its limitations as commented below:
      ListView.builder(
            
      // [itemCount] must be specified/can not be infinite
      itemCount:  flutterFavorites.length,
      
      // [shrinkWrap] must be set as "true", otherwise you'll get [RenderViewport] issue
      shrinkWrap:  true,
      
      // For better control set [NeverScrollableScrollPhysics] to [physics]
      physics:  const  NeverScrollableScrollPhysics(),

      itemBuilder: (_,  int  index) { ... },
      ),
    ],
  ),
)
...
```

#### 1. `CupertinoRefreshSliver`
```dart
...
CustomScrollView(
  slivers: [
    // Place CupertinoRefreshSliver as the first element for the slivers parameter.
    CupertinoRefreshSliver(
      onRefresh: _fetch,
    ),
    SliverList(...),
  ],
)
...
```


## 📈 Performance concerns
While `CupertinoRefreshSliver` has no performance drawbacks, `CupertinoRefresh` can have and it's related to how scrollable widgets behave in the Flutter framework. Although you may not end up using this package consider reading the part below so that you can be aware of performance-related issues while using any kind of scrollable widget in Flutter.

Because the `CupertinoRefresh` is itself an intrinsically scrollable widget if you add another scrollable widget to it as a child, you'll get this error: `Vertical viewport was given unbounded height.` 😖

The long and the short of the matter is that scrollable widgets like `ListView`, `GridView`, `PageView`, and `CustomScrollView` try to fill all the available space given by the parent element, even when the list items would require less space and while `CupertinoRefresh` is also a scrollable widget itself we get this error. <a href="https://stackoverflow.com/a/54008230">Read detailed.</a>

The solution for such cases is to set `shrinkWrap` property of the scrollable widget as `true` and `physics` as `NeverScrollableScrollPhysics` (or <a href="https://www.fluttercampus.com/guide/136/how-to-solve-vertical-viewport-was-given-unbounded-height-error-on-flutter">setting a bounded height on the parent widget</a>).

Now, setting `shrinkWrap` as `true` is the root of the performance drawback. According to the Flutter <a href="https://api.flutter.dev/flutter/widgets/ScrollView/shrinkWrap.html">documentation</a>, using `shrinkWrap` in lists is expensive performance-wise and should be avoided. Why? Because, when used as such, the scrollable widget builds all children at once (Flutter issue <a href="https://github.com/flutter/flutter/issues/26072">#26072</a>).

In conclusion I would say, whether you use this package or not, always consider using `Sliver`s for better performant.

Read more:
-- dart-lang issue: <a href="https://github.com/dart-lang/linter/issues/3496">#3496</a>
-- dart code metric: <a href="https://dartcodemetrics.dev/docs/rules/flutter/avoid-shrink-wrap-in-lists">avoid-shrink-wrap-in-lists</a>
-- "Decoding Flutter" series: <a href="https://www.youtube.com/watch?v=LUqDNnv_dh0">ShrinkWrap vs Slivers</a>

## 🙏 Credits

Thanks to <a href="https://github.com/mrjnlcn">Aljan Shikiyev</a> for being inspiration for this `Widget` and `Sliver`.

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

MIT License