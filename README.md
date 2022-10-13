
# cupertino_refresh

iOS-styled refresh control Widget and Sliver for Flutter.

<img src="https://raw.githubusercontent.com/porelarte/cupertino-refresh/master/.docs/cover.png" alt="cover_picture" />

## 🚀 Motivation

While developing one of my client's mobile application I felt a need for a UI component for the purpose that whenever the user wants to refresh the page, he/she should be able to trigger an all-over start for the screen and its data instead of going back and reopening the screen. By using `RefreshIndicator` which is included in the `material` package of Flutter the mission was achieved. But, it was, seemingly, exotic on iOS devices. I felt a need, the need for an iOS-styled refresh control, which turned out to be included in the `cupertino` package of Flutter as `CupertinoRefreshSliver`.

So, why package then? 🤔

You see, `CupertinoRefreshSliver` is a sliver which means in order to be able to use it you have to use `CustomScrollView` to layout your widgets and `Sliver`s for everything, although, if not for everything but at least with wrapping widgets inside of a `SliverToBoxAdapter`, yet, always, `Sliver`s are there. But who wants to refactor every screen, page, or whatever metric you have for view just to have iOS-styled refresh control? I didn't, so I've created a workaround which I call: the `CupertinoRefresh` widget.

  

PS: If you're already using `CustomScrollView` for the layout you can use `CupertinoRefreshSliver` directly as the first element of your `Sliver`s list. See example below.

## 🕹️ Usage

There are two types of refresh control as mentioned above:
1. `CupertinoRefresh`: a widget that can wrap any other widget.
2. `CupertinoRefreshSliver`: a Sliver that can be used in combination with Slivers, mostly `CustomScrollView`.

#### 1. `CupertinoRefresh`

```dart
...
CupertinoRefresh.withScrollbar(
  onRefresh: () {
    return _fetchData();
  },

  /// The child of [CupertinoRefresh] widget must not be necessarily a
  /// scrollable widget as it can be any widget

  child:  Column(
    children: [
    
      /// While using with [SingleChildScrollView] is seamless,
      /// [ListView] has its limitations as commented below:
      ListView.builder(
            
      // [itemCount] must be specified/can not be infinite
      itemCount:  flutterFavorites.length,
      
      /// [shrinkWrap] must be set as "true", otherwise you'll get [RenderViewport] issue
      shrinkWrap:  true,
      
      /// For better control set [NeverScrollableScrollPhysics] to [physics]
      physics:  const  NeverScrollableScrollPhysics(),

      itemBuilder: (_,  int  index) { ... },
      ),
    ],
  ),
)
```

## 🙏 Credits

Thanks to <a href="https://github.com/mrjnlcn">Aljan Shikiyev</a> for being inspiration for this `Widget` and `Sliver`.

## 🐞 Bugs/Requests

If you encounter any problems please open an issue. If you feel the library is missing a feature, please raise a ticket on GitHub and we'll look into it. Pull requests are welcome.

## 📃 License

MIT License