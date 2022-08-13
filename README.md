<p align="center">
<img src="https://raw.githubusercontent.com/porelarte/cupertino-refresh/master/_external/cover.png" alt="cupertino_refresh" />
</p>
<h2 align="center">cupertino_refresh</h2>


## Motivation behind the package

While developing one of my client's mobile application I felt a need for a UI component for the purpose that whenever the user wants to refresh the page, he/she should be able to trigger an all-over start for the screen and its data instead of going back and reopening the screen. By using `RefreshIndicator` which is included in the `material` package of Flutter the mission was achieved. But, it was, seemingly, exotic on iOS devices. I felt a need, the need for an iOS-styled refresh indicator, which turned out to be included in the `cupertino` package of Flutter as `CupertinoRefreshSliver`. 

So, why package then? 🤔

You see, `CupertinoRefreshSliver` is a sliver which means in order to be able to use it you have to use `CustomScrollView` to layout your widgets and `Sliver`s for everything, although, if not for everything but at least with wrapping widgets inside of a `SliverToBoxAdapter`, yet, always, `Sliver`s are there. But who wants to refactor every screen, page, or whatever metric you have for view just to have iOS-styled refresh control? I didn't, so I've created a workaround which I call: the `CupertinoRefresh` widget.

PS: If you're already using `CustomScrollView` for the layout you can use `CupertinoRefreshSliver` directly as the first element of your `Sliver`s list. See example below.
