package helpClasses;

public class ParamCheck {

	public static void checkNameAndPassword(String userName, String userPassword)
			throws BadParameterException {
		if (userName.isEmpty() || userPassword.isEmpty()) {
			throw new BadParameterException(
					"User name and password must not be empty");
		} else if (userPassword.length() < 5) {
			throw new BadParameterException(
					"Password must be at least 5 characters long");
		}
	}

	public static void checkName(String name) throws BadParameterException {
		if (name.isEmpty()) {
			throw new BadParameterException("Name must not be empty");
		}
	}

	public static Integer checkAmount(String amount)
			throws BadParameterException {
		Integer amountInt;
		if (amount.isEmpty()) {
			throw new BadParameterException("Amount must not be empty");
		}
		try {
			amountInt = Integer.parseInt(amount);
		} catch (NumberFormatException e) {
			throw new BadParameterException(
					"Amount must be a whole number");
		}
		return amountInt;
	}

	public static Double checkPrice(String price) throws BadParameterException {
		Double priceDouble;
		if (price.isEmpty()) {
			String msg = "Price must not be empty";
			throw new BadParameterException(msg);
		}
		try {
			priceDouble = Double.parseDouble(price);
			if (priceDouble >= 100000) {
				String msg = "Price mus be smaller than 100000";
				throw new BadParameterException(msg);
			}
			// auf 2 Nachkommastellen kaufmaennisch runden
			priceDouble = Math.round(priceDouble * Math.pow(10, 2))
					/ Math.pow(10, 2);
		} catch (NumberFormatException e) {
			String msg = "Price can at most contain 2 decimals";
			throw new BadParameterException(msg);
		}
		return priceDouble;
	}
}
