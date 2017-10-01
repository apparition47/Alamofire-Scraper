# Alamofire-Scraper

A extension to scrape HTML with [Kanna](https://github.com/tid-kijyun/Kanna) and [Alamofire](https://github.com/Alamofire/Alamofire).

## Swift version

Alamofire-Scraper | Swift version | Alamofire | Kanna
-------------        | --------------| ----------| ----------
0.x                  | Swift 4.x     |    4.5.x  |  feature/v4.0.0

## Requirements

- iOS 8.0+ / Mac OS X 10.9+
- Xcode 9.0+
- Swift 4.0+

## Install

Install [libxml2](http://xmlsoft.org)
```bash
# macOS
$ brew install libxml2
$ brew link --force libxml2

# Linux(Ubuntu)
$ sudo apt-get install libxml2-dev
```

[Carthage](https://github.com/Carthage/Carthage):

```
github "apparition47/Alamofire-Scraper" "master"
```

In the project settings add $(SDKROOT)/usr/include/libxml2 to the "header search paths" field


## Usage

```swift
Alamofire.request(URL, method: .get, parameters: parameters, encoding: URLEncoding.default)
         .responseHTML(scrapeBy: "a.w3-bar-item") { dataResponse in
                    if let results = response.result.value {
                        print(results)
                    }
                  })
```

## License

MIT