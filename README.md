# AC-iOS-Music-ParsingJSON

## Parsing Data

- Given an endpoint, copy and paste the JSON into Xcode.  Make a new file called customname.json and save it at the top level of your project.


In order to access your json and convert it to type Data, use the code below:

```swift
if let path = Bundle.main.path(forResource: "nameHere", ofType: "json") {
    let myURL = URL(fileURLWithPath: path)
    if let data = try? Data(contentsOf: myURL) {
		//USE Data HERE
    }
}
```

- Create a model for each Data Set

```swift
class ThingOne {
	var propOne: Int
	var propTwo: [String]
	init(propOne: Int, propTwo: [String]) {
		self.propOne = propOne
		self.propTwo = propTwo
	}
}
```

- Create a convenience initializer that takes in something jsonlike as input:
- Note: If you don't find the property at that key, you can either:

1. return nil in which case no object gets created
2. set that property to some default value


```swift
class ThingOne {
	var propOne: Int
	var propTwo: [String]
	init(propOne: Int, propTwo: [String]) {
		self.propOne = propOne
		self.propTwo = propTwo
	}
	convenience init?(from jsonDict: [String: Any]) {
		let propOne: Int = jsonDict["propOne"] as? Int else {return nil}
		let propTwo: [String] = jsonDict["propTwo"] as? [String] ?? []
		self.init(propOne: propOne, propTwo: propTwo)
	}
}

```

- Create a class function that takes Data? as input and returns an array of Swift objects

```swift
class ThingOne {
	var propOne: Int
	var propTwo: [String]
	init(propOne: Int, propTwo: [String]) {
		self.propOne = propOne
		self.propTwo = propTwo
	}
	convenience init?(from jsonDict: [String: Any]) {
		let propOne = jsonDict["propOne"] as? Int else {return nil}
		let propTwo = jsonDict["propTwo"] as? [String] ?? ""
		self.init(propOne: propOne, propTwo: propTwo)
	}

	class func getThings(from data: Data?) -> [ThingOne] {
    do {
      let json = try JSONSerialization.jsonObject(with: data, options: [])
      //Parse the data here
    }
    catch {
    }
		return []
	}
}
```
- In your View Controller, load data by calling the class function above.
