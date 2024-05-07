package interest

func InterestRate(balance float64) float32 {
	if balance < 0 {
		return 3.213
	} else if balance < 1000 {
		return 0.5
	} else if balance < 5000 {
		return 1.621
	} else {
		return 2.475
	}
}

func Interest(balance float64) float64 {
	rate := InterestRate(balance)
	return balance * float64(rate) / 100
}

func AnnualBalanceUpdate(balance float64) float64 {
	return balance + Interest(balance)
}

func YearsBeforeDesiredBalance(balance, targetBalance float64) int {
	years := 0
	for ; balance < targetBalance; years++ {
		balance = AnnualBalanceUpdate(balance)
	}
	return years
}
