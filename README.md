<p align="center">
<img src="https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/bloc_logo_full.png" height="100" alt="Bloc" />
</p>
<h2 align="center">cupertino_refresh</h2>


## Motivation behind the package

While developing one of my client's mobile application I felt a need for a UI component for the purpose that whenever the user wants to refresh the page, he/she should be able to trigger an all-over start for the screen and its data instead of going back and reopening the screen. By using `RefreshIndicator` which is included in the `material` package of Flutter the mission was achieved. But, it was, seemingly, exotic on iOS devices. I felt a need, the need for an iOS-like refresh indicator, which turned out to be included in the `cupertino` package of Flutter as `CupertinoRefreshSliver`. 

So, why package then? 🤔

You see, `CupertinoRefreshSliver` is a sliver which means in order to be able to use it you have to use `CustomScrollView` to layout your widgets and `Sliver`s for everything, although, if not for everything but at least with wrapping widgets inside of a `SliverToBoxAdapter`, yet, always, `Sliver`s are there. But who wants to refactor every screen, page, or whatever metric you have for view just to have iOS-like refresh control? I didn't, so I've created a workaround which I call: the `CupertinoRefresh` widget.

PS: If you're already using `CustomScrollVeiew` for the layout you can use `CupertinoRefreshSliver` directly as the first element of your `Sliver`s list. See example below.

### Cubit

![Cubit Architecture](https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/cubit_architecture_full.png)

A `Cubit` is class which extends `BlocBase` and can be extended to manage any type of state. `Cubit` requires an initial state which will be the state before `emit` has been called. The current state of a `cubit` can be accessed via the `state` getter and the state of the `cubit` can be updated by calling `emit` with a new `state`.

![Cubit Flow](https://raw.githubusercontent.com/felangel/bloc/master/docs/assets/cubit_flow.png)

State changes in cubit begin with predefined function calls which can use the `emit` method to output new states. `onChange` is called right before a state change occurs and contains the current and next state.

#### Creating a Cubit

```dart
/// A `CounterCubit` which manages an `int` as its state.
class CounterCubit extends Cubit<int> {
  /// The initial state of the `CounterCubit` is 0.
  CounterCubit() : super(0);

  /// When increment is called, the current state
  /// of the cubit is accessed via `state` and
  /// a new `state` is emitted via `emit`.
  void increment() => emit(state + 1);
}
```

#### Using a Cubit

```dart
void main() {
  /// Create a `CounterCubit` instance.
  final cubit = CounterCubit();

  /// Access the state of the `cubit` via `state`.
  print(cubit.state); // 0

  /// Interact with the `cubit` to trigger `state` changes.
  cubit.increment();

  /// Access the new `state`.
  print(cubit.state); // 1

  /// Close the `cubit` when it is no longer needed.
  cubit.close();
}
```

#### Observing a Cubit

`onChange` can be overridden to observe state changes for a single `cubit`.

`onError` can be overridden to observe errors for a single `cubit`.

```dart
class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);

  void increment() => emit(state + 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(error, stackTrace);
  }
}
```

`BlocObserver` can be used to observe all `cubits`.

```dart
class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
```

```dart
void main() {
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
}
```

## Dart Versions

- Dart 2: >= 2.12

## Examples

- [Counter](https://github.com/felangel/bloc/tree/master/packages/bloc/example) - an example of how to create a `CounterBloc` in a pure Dart app.

## Maintainers

- [Felix Angelov](https://github.com/felangel)