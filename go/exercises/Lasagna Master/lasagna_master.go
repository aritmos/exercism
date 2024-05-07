package lasagna

func PreparationTime(layers []string, layerPrepTime int) int {
	if layerPrepTime == 0 {
		layerPrepTime = 2
	}
	return len(layers) * layerPrepTime
}

func Quantities(layers []string) (noodles int, sauce float64) {
	for _, layer := range layers {
		switch layer {
		case "noodles":
			noodles += 50
		case "sauce":
			sauce += 0.2
		}
	}
	return
}

func AddSecretIngredient(friendIngredients, myIngredients []string) []string {
	myIngredients[len(myIngredients)-1] = friendIngredients[len(friendIngredients)-1]
	return myIngredients
}

func ScaleRecipe(quantities []float64, portions int) []float64 {
	scaledQuantities := make([]float64, len(quantities))
	scale := float64(portions) / 2.0
	for i, q := range quantities {
		scaledQuantities[i] = q * scale
	}
	return scaledQuantities
}
