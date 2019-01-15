# Wrapper for iOS Unified Logging

## Usage

If you wanna show a generic log use:

```swift
    logger("This is a generic log")
```

Will ouput something like this:

```
[ViewController.swift]:20 .viewDidLoad() -> This is a generic log
```

- `ViewController.swift` is the name of the file where the `logger()` is called from
- `20` is the line
-  `.viewDidLoad()` is the function `logger()` is in


### Log category

You can also assign a category to a log:

```swift
    logger("This log belongs to the Network Category", .network)
```


### Log type

On top of that, you can choose a type for the log:

`Info` is the default type

```swift
logger("This is a standard log", .network, .info)
```

`Debug` logs will not be displayed if you build your app for release

```swift
logger("This log will not be displayed in release", .network, .debug)
```

`Warning` logs will be marked with a yellow dot

```swift
logger("This log contains a warning", .network, .warning)
```

`Error` logs will be marked with a red dot

```swift
logger("This log contains an error", .network, .error)
```

You can omit the category and the type. The resulting log will be in `General` category, as an `Info` type


### Private logs

There's also another optional parameter: `shouldBePrivate`:  default value is `false`. 
If set to true it will obfuscate the content of the log (only if your app is not running from XCode).

Use this to hide sensible data.

```swift
logger("This log will be obfuscated", .general, .info, shouldBePrivate: true)
```

Will output:

```
[<private>]:<private> .<private> -> <private>
```


In my example i also added a special category named `.auth`. Messages in this category will always be obfuscated, and are represented in a different way:

```swift
logger("Login credentials: { usr: \(username), pwd: \(password) }", .auth)
```

Will output:

```
[AUTH]: <private>
```

## Important

You should set the subsystem for your app in:

```swift
    // replace "com.your.subsystem" with what you want, for example your bundle
    let subsystem = "com.your.subsystem"
```

## How to see logs

 ⚠️ Work in progress
