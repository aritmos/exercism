// Package weather contains functionality to get the current weather in a given location.
package weather

// CurrentCondition is the current weather condition.
var CurrentCondition string

// CurrentLocation is the current weather location.
var CurrentLocation string

// Forecast takes in weather information (the location and weather condition respectively)
// and returns a formatted string detailing the weather.
func Forecast(city, condition string) string {
	CurrentLocation, CurrentCondition = city, condition
	return CurrentLocation + " - current weather condition: " + CurrentCondition
}
