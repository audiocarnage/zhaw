package ch.zhaw.securitylab.marketplace.rest;

import ch.zhaw.securitylab.marketplace.dto.CheckoutDto;
import ch.zhaw.securitylab.marketplace.dto.CredentialDto;
import ch.zhaw.securitylab.marketplace.dto.ProductDto;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Formatter;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import javax.net.ssl.SSLContext;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import org.glassfish.jersey.SslConfigurator;

public class Test {

    private final static String CREDENTIALS_SALES = "alice:rabbit";
    private final static String CREDENTIALS_MARKETING = "robin:arrow";
    private final static String CREDENTIALS_PRODUCTMANAGER = "luke:force";
    private final static String CREDENTIALS_WRONG_PASSWORD_SALES = "alice:wrongpassword";
    private final static String CREDENTIALS_WRONG_PASSWORD_MARKETING = "robin:wrongpassword";
    private final static String CREDENTIALS_WRONG_USER = "wronguser:wrongpassword";
    private final static String BASE_URL = "https://localhost:8181/Marketplace_Lab-rest/rest";
    private static SSLContext sslContext;
    private static String authTokenSales;
    private static String authTokenMarketing;
    private static String authTokenProductManager;
    private final static String AUTH_TOKEN_WRONG_TOKEN = "alice:2AC064EE4761D6CC9BEFDA91A4523805";
    private final static String AUTH_TOKEN_WRONG_USER = "wronguser:2AC064EE4761D6CC9BEFDA91A4523805";
    private final static boolean VERBOSE = true;
    
    private final static SummaryPrinter summaryPrinter = new SummaryPrinter();

    public static void main(String[] args) throws Exception {
        String category = "";
        Response response;
        BooleanString result;

        // Create the SSL context
        SslConfigurator sslConfig = SslConfigurator.newInstance()
                .trustStoreFile("/home/user/payara41/glassfish/domains/domain1/config/keystore.jks")
                .trustStorePassword("changeit");
        sslContext = sslConfig.createSSLContext();

        // Authenticate
        category = "Authentication tests";
        System.out.println(category + ":\n");
        response = postAuthenticate(CREDENTIALS_WRONG_PASSWORD_MARKETING);
        printResults(response, 400, "wrong", null, VERBOSE, category);
        response = postAuthenticate(CREDENTIALS_WRONG_USER);
        printResults(response, 400, "wrong", null, VERBOSE, category);
        response = postAuthenticate(CREDENTIALS_SALES);
        result = printResults(response, 200, "Token", null, VERBOSE, category);
        if (result.bool) {
            authTokenSales = "alice:" + getToken(result.string);
        }
        response = postAuthenticate(CREDENTIALS_MARKETING);
        result = printResults(response, 200, "Token", null, VERBOSE, category);
        if (result.bool) {
            authTokenMarketing = "robin:" + getToken(result.string);
        }
        response = postAuthenticate(CREDENTIALS_PRODUCTMANAGER);
        result = printResults(response, 200, "Token", null, VERBOSE, category);
        if (result.bool) {
            authTokenProductManager = "luke:" + getToken(result.string);
        }

        // Print authentication tokens
        if (VERBOSE) {
            System.out.println("Authentication Tokens:");
            System.out.println(AUTH_TOKEN_WRONG_TOKEN);
            System.out.println(AUTH_TOKEN_WRONG_USER);
            System.out.println(authTokenSales);
            System.out.println(authTokenMarketing);
            System.out.println(authTokenProductManager);
            System.out.println();
        }

        // Un-authenticate all tokens
        category = "Un-Authentication tests";
        System.out.println(category + ":\n");
        response = deleteAuthenticate(false, "");
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAuthenticate(true, AUTH_TOKEN_WRONG_TOKEN);
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAuthenticate(true, AUTH_TOKEN_WRONG_USER);
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAuthenticate(true, authTokenSales);
        printResults(response, 204, null, null, VERBOSE, category);
        response = deleteAuthenticate(true, authTokenMarketing);
        printResults(response, 204, null, null, VERBOSE, category);
        response = deleteAuthenticate(true, authTokenProductManager);
        printResults(response, 204, null, null, VERBOSE, category);

        // GET admin purchase, should not work
        category = "GET admin/purchases without valid token tests";
        System.out.println(category + ":\n");
        response = getAdminPurchases(true, AUTH_TOKEN_WRONG_TOKEN);
        printResults(response, 401, null, null, VERBOSE, category);
        response = getAdminPurchases(true, AUTH_TOKEN_WRONG_USER);
        printResults(response, 401, null, null, VERBOSE, category);
        response = getAdminPurchases(true, authTokenMarketing);
        printResults(response, 401, null, null, VERBOSE, category);

        // Authenticate
        category = "Authentication tests";
        System.out.println(category + ":\n");
        response = postAuthenticate(CREDENTIALS_SALES);
        result = printResults(response, 200, "Token", null, VERBOSE, category);
        if (result.bool) {
            authTokenSales = "alice:" + getToken(result.string);
        }
        response = postAuthenticate(CREDENTIALS_MARKETING);
        result = printResults(response, 200, "Token", null, VERBOSE, category);
        if (result.bool) {
            authTokenMarketing = "robin:" + getToken(result.string);
        }
        response = postAuthenticate(CREDENTIALS_PRODUCTMANAGER);
        result = printResults(response, 200, "Token", null, VERBOSE, category);
        if (result.bool) {
            authTokenProductManager = "luke:" + getToken(result.string);
        }

        // Print authentication tokens
        if (VERBOSE) {
            System.out.println("Authentication Tokens:");
            System.out.println(AUTH_TOKEN_WRONG_TOKEN);
            System.out.println(AUTH_TOKEN_WRONG_USER);
            System.out.println(authTokenSales);
            System.out.println(authTokenMarketing);
            System.out.println(authTokenProductManager);
            System.out.println();
        }

        // GET products
        category = "GET products tests";
        System.out.println(category + ":\n");
        response = getProducts("", false, "");
        printResults(response, 200, "0002", null, VERBOSE, category);
        response = getProducts("DVD", false, "");
        printResults(response, 200, "DVD", null, VERBOSE, category);
        response = getProducts("nomatch", false, "");
        printResults(response, 200, null, "0001", VERBOSE, category);
        response = getProducts("", true, authTokenSales);
        printResults(response, 200, "0002", null, VERBOSE, category);
        response = getProducts("looooooooooooooooooooooooooooooooooooooooooooooooooo", false, "");
        printResults(response, 400, "longer", null, VERBOSE, category);

        // POST purchases
        category = "POST purchases tests";
        System.out.println(category + ":\n");
        List<String> articles = new ArrayList<>();
        articles.add("0001");
        articles.add("0003");
        response = postPurchase("Max", "Meier", "1111 2222 3333 4444", articles, false, "");
        printResults(response, 204, null, null, VERBOSE, category);
        articles.add("9999");
        response = postPurchase("Max", "Meier", "1111 2222 3333 4444", articles, false, "");
        printResults(response, 204, null, null, VERBOSE, category);
        response = postPurchase("M", "M", "1111 2222 3333 4444", articles, false, "");
        printResults(response, 400, "valid first", null, VERBOSE, category);
        response = postPurchase("Max", "Meier", "1111 2222 3333 4445", articles, false, "");
        printResults(response, 400, "valid credit", null, VERBOSE, category);
        articles.clear();
        articles.add("10001");
        articles.add("30003");
        response = postPurchase("Moritz", "Mueller", "1111 2222 3333 4444", articles, false, "");
        printResults(response, 400, "no valid product", null, VERBOSE, category);
        response = postPurchase("Moritz", "Mueller", "1111 2222 3333 4445", articles, false, "");
        printResults(response, 400, "valid credit", null, VERBOSE, category);
        articles.clear();
        response = postPurchase("Moritz", "Mueller", "1111 2222 3333 4445", articles, true, authTokenSales);
        printResults(response, 400, "valid credit", null, VERBOSE, category);

        // GET admin/purchases
        category = "GET admin/purchases tests";
        System.out.println(category + ":\n");
        response = getAdminPurchases(true, AUTH_TOKEN_WRONG_TOKEN);
        printResults(response, 401, null, null, VERBOSE, category);
        response = getAdminPurchases(true, AUTH_TOKEN_WRONG_USER);
        printResults(response, 401, null, null, VERBOSE, category);
        response = getAdminPurchases(true, authTokenProductManager);
        printResults(response, 403, null, null, VERBOSE, category);
        response = getAdminPurchases(true, authTokenSales);
        printResults(response, 200, "totalPrice", null, VERBOSE, category);
        response = getAdminPurchases(true, authTokenMarketing);
        printResults(response, 200, "totalPrice", null, VERBOSE, category);

        // DELETE admin/purchases
        category = "DELETE admin/purchases tests";
        System.out.println(category + ":\n");
        response = deleteAdminPurchase("1", false, "");
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAdminPurchase("1", true, AUTH_TOKEN_WRONG_TOKEN);
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAdminPurchase("1", true, AUTH_TOKEN_WRONG_USER);
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAdminPurchase("1", true, authTokenSales);
        printResults(response, 204, null, null, VERBOSE, category);
        response = deleteAdminPurchase("1", true, authTokenMarketing);
        printResults(response, 403, null, null, VERBOSE, category);
        response = deleteAdminPurchase("99999", true, authTokenSales);
        printResults(response, 400, "not exist", null, VERBOSE, category);
        response = deleteAdminPurchase("9999999", true, authTokenSales);
        printResults(response, 400, "between", null, VERBOSE, category);

        // GET admin/products
        category = "GET admin/products tests";
        System.out.println(category + ":\n");
        response = getAdminProducts(true, AUTH_TOKEN_WRONG_TOKEN);
        printResults(response, 401, null, null, VERBOSE, category);
        response = getAdminProducts(true, AUTH_TOKEN_WRONG_USER);
        printResults(response, 401, null, null, VERBOSE, category);
        response = getAdminProducts(true, authTokenMarketing);
        printResults(response, 403, null, null, VERBOSE, category);
        response = getAdminProducts(true, authTokenProductManager);
        printResults(response, 200, "username", null, VERBOSE, category);

        // POST admin/products
        category = "POST admin/products tests";
        System.out.println(category + ":\n");
        response = postAdminProducts("test", "description", new BigDecimal("5.55"), false, "");
        printResults(response, 401, null, null, VERBOSE, category);
        response = postAdminProducts("test", "description", new BigDecimal("5.55"), true, AUTH_TOKEN_WRONG_TOKEN);
        printResults(response, 401, null, null, VERBOSE, category);
        response = postAdminProducts("test", "description", new BigDecimal("5.55"), true, AUTH_TOKEN_WRONG_USER);
        printResults(response, 401, null, null, VERBOSE, category);
        response = postAdminProducts("test", "description", new BigDecimal("5.55"), true, authTokenSales);
        printResults(response, 403, null, null, VERBOSE, category);
        response = postAdminProducts("0001", "description", new BigDecimal("5.55"), true, authTokenProductManager);
        printResults(response, 400, "same code", null, VERBOSE, category);
        response = postAdminProducts("111", "shorty", new BigDecimal("5.555"), true, authTokenProductManager);
        printResults(response, 400, "valid", null, VERBOSE, category);
        response = postAdminProducts("1111", "description", new BigDecimal("-1"), true, authTokenProductManager);
        printResults(response, 400, "negative", null, VERBOSE, category);
        response = postAdminProducts("1111", "description", new BigDecimal("1000000"), true, authTokenProductManager);
        printResults(response, 400, "smaller", null, VERBOSE, category);
        response = postAdminProducts("1111", "description", new BigDecimal("5.55"), true, authTokenProductManager);
        printResults(response, 204, null, null, VERBOSE, category);

        // DELETE admin/products
        category = "DELETE admin/products tests";
        System.out.println(category + ":\n");
        response = deleteAdminProduct("4", false, "");
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAdminProduct("4", true, AUTH_TOKEN_WRONG_TOKEN);
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAdminProduct("4", true, AUTH_TOKEN_WRONG_USER);
        printResults(response, 401, null, null, VERBOSE, category);
        response = deleteAdminProduct("4", true, authTokenSales);
        printResults(response, 403, null, null, VERBOSE, category);
        response = deleteAdminProduct("4", true, authTokenProductManager);
        printResults(response, 403, "own products", null, VERBOSE, category);
        response = deleteAdminProduct("3", true, authTokenProductManager);
        printResults(response, 204, null, null, VERBOSE, category);
        response = deleteAdminProduct("99999", true, authTokenProductManager);
        printResults(response, 400, "not exist", null, VERBOSE, category);
        response = deleteAdminProduct("9999999", true, authTokenProductManager);
        printResults(response, 400, "between", null, VERBOSE, category);
        
        // Login Throttling
        category = "Login Throttling tests";
        System.out.println(category + ":\n");
        response = deleteAuthenticate(true, authTokenSales);
        printResults(response, 204, null, null, VERBOSE, category);
        response = postAuthenticate(CREDENTIALS_WRONG_PASSWORD_SALES);
        printResults(response, 400, "wrong", null, VERBOSE, category);
        response = postAuthenticate(CREDENTIALS_WRONG_PASSWORD_SALES);
        printResults(response, 400, "wrong", null, VERBOSE, category);
        response = postAuthenticate(CREDENTIALS_WRONG_PASSWORD_SALES);
        printResults(response, 400, "wrong", null, VERBOSE, category);
        response = postAuthenticate(CREDENTIALS_WRONG_PASSWORD_SALES);
        printResults(response, 400, "minute", null, VERBOSE, category);
        response = postAuthenticate(CREDENTIALS_SALES);
        printResults(response, 400, "minute", null, VERBOSE, category);
        
        // Print summary
        System.out.print(summaryPrinter.toString());
    }

    private static Response postAuthenticate(String credential) throws Exception {
        String[] credentialArray = credential.split(":");
        String username = credentialArray[0];
        String password = credentialArray[1];
        System.out.println("POST authenticate " + username + "|" + password);
        CredentialDto credentialDto = new CredentialDto();
        credentialDto.setUsername(username);
        credentialDto.setPassword(password);
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).path("authenticate");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        return invocationBuilder.post(Entity.entity(credentialDto, MediaType.APPLICATION_JSON));
    }

    private static Response deleteAuthenticate(boolean auth, String credentials) throws Exception {
        System.out.println("DELETE authenticate, auth = " + auth
                + ", credentials = '" + credentials + "'");
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).
                path("authenticate");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        if (auth) {
            invocationBuilder.header("Authorization", createAuthHeader(credentials));
        }
        return invocationBuilder.delete();
    }

    private static Response getProducts(String filter, boolean auth, String credentials) throws Exception {
        System.out.println("GET products, filter = '" + filter + "', auth = " + auth
                + ", credentials = '" + credentials + "'");
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).path("products");
        if (!filter.equals("")) {
            webTarget = webTarget.queryParam("filter", filter);
        }
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        if (auth) {
            invocationBuilder.header("Authorization", createAuthHeader(credentials));
        }
        return invocationBuilder.get();
    }

    private static Response postPurchase(String firstname, String lastname, String creditCardNumber,
            List<String> productCodes, boolean auth, String credentials) throws Exception {
        String productCodesString = "";
        for (String s : productCodes) {
            if (!productCodesString.equals("")) {
                productCodesString += ",";
            }
            productCodesString += s;
        }
        System.out.println("POST purchases " + firstname + "|" + lastname + "|" + creditCardNumber + "|"
                + productCodesString + ", auth = " + auth + ", credentials = '" + credentials + "'");
        CheckoutDto checkoutDto = new CheckoutDto();
        checkoutDto.setFirstname(firstname);
        checkoutDto.setLastname(lastname);
        checkoutDto.setCreditCardNumber(creditCardNumber);
        checkoutDto.setProductCodes(productCodes);
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).path("purchases");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        if (auth) {
            invocationBuilder.header("Authorization", createAuthHeader(credentials));
        }
        return invocationBuilder.post(Entity.entity(checkoutDto, MediaType.APPLICATION_JSON));
    }

    private static Response getAdminPurchases(boolean auth, String credentials) throws Exception {
        System.out.println("GET admin/purchases, auth = " + auth + ", credentials = '" + credentials + "'");
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).path("admin/purchases");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        if (auth) {
            invocationBuilder.header("Authorization", createAuthHeader(credentials));
        }
        return invocationBuilder.get();
    }

    private static Response deleteAdminPurchase(String purchaseId, boolean auth, String credentials) throws Exception {
        System.out.println("DELETE admin/purchases, id = " + purchaseId + ", auth = " + auth
                + ", credentials = '" + credentials + "'");
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).
                path("admin/purchases/" + purchaseId);
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        if (auth) {
            invocationBuilder.header("Authorization", createAuthHeader(credentials));
        }
        return invocationBuilder.delete();
    }

    private static Response getAdminProducts(boolean auth, String credentials) throws Exception {
        System.out.println("GET admin/products, auth = " + auth + ", credentials = '" + credentials + "'");
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).path("admin/products");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        if (auth) {
            invocationBuilder.header("Authorization", createAuthHeader(credentials));
        }
        return invocationBuilder.get();
    }

    private static Response postAdminProducts(String code, String description, BigDecimal price,
            boolean auth, String credentials) throws Exception {
        System.out.println("POST admin/products " + code + "|" + description + "|" + price
                + ", auth = " + auth + ", credentials = '" + credentials + "'");
        ProductDto productDto = new ProductDto();
        productDto.setCode(code);
        productDto.setDescription(description);
        productDto.setPrice(price);
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).path("admin/products");
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        if (auth) {
            invocationBuilder.header("Authorization", createAuthHeader(credentials));
        }
        return invocationBuilder.post(Entity.entity(productDto, MediaType.APPLICATION_JSON));
    }

    private static Response deleteAdminProduct(String productId, boolean auth, String credentials) throws Exception {
        System.out.println("DELETE admin/products, id = " + productId + ", auth = " + auth
                + ", credentials = '" + credentials + "'");
        Client client = ClientBuilder.newBuilder().sslContext(sslContext).build();
        WebTarget webTarget = client.target(BASE_URL).
                path("admin/products/" + productId);
        Invocation.Builder invocationBuilder = webTarget.request(MediaType.APPLICATION_JSON);
        if (auth) {
            invocationBuilder.header("Authorization", createAuthHeader(credentials));
        }
        return invocationBuilder.delete();
    }

    private static String createAuthHeader(String credentials) {
        return "Basic " + new String(Base64.getEncoder().encode(credentials.getBytes()));
    }

    private static void printHeaders(Response response) {
        System.out.println("Status code: " + response.getStatus());
        System.out.println("Media type: " + response.getMediaType());
    }

    private static String getBody(Response response) {
        return response.readEntity(String.class);
    }

    private static void printBody(String body) {
        System.out.println("Body: " + body);
    }

    private static BooleanString printResults(Response response, int statusCode,
            String included, String notIncluded, boolean verbose, String category) {
        String body = getBody(response);
        if (verbose) {
            printHeaders(response);
            printBody(body);
        }
        boolean passed = true;
        if ((response.getStatus() != statusCode)
                || (included != null && !body.contains(included))
                || (notIncluded != null && body.contains(notIncluded))) {
            passed = false;
        }
        if (passed) {
            summaryPrinter.Passed(category);
            System.out.println("=> PASSED");
        } else {
            summaryPrinter.Failed(category);
            System.out.println("=> FAILED");
        }
        System.out.println();
        return new BooleanString(passed, body);
    }

    private static String getToken(String token) {
        return token.substring(24, 24 + 32);
    }
}

class BooleanString {

    boolean bool;
    String string;

    public BooleanString(boolean bool, String string) {
        this.bool = bool;
        this.string = string;
    }
}

class SummaryPrinter {

    private HashMap<String, Results> summaryMap = new HashMap<>();

    public void Passed(String category) {
        this.getResults(category).Passed();
    }

    public void Failed(String category) {
        this.getResults(category).Failed();
    }

    private Results getResults(String category) {
        if (!summaryMap.containsKey(category)) {
            summaryMap.put(category, new Results());
        }
        return summaryMap.get(category);
    }

    @Override
    public String toString() {
        int passed = 0, failed = 0;
        StringBuilder summary = new StringBuilder();
        Formatter formatter = new Formatter(summary, Locale.US);

        summary.append("SUMMARY\n");
        summary.append(new String(new char[76]).replace("\0", "="));
        summary.append("\n");

        for (HashMap.Entry<String, Results> entry : summaryMap.entrySet()) {
            formatter.format("%-50s%10s%3d%10s%3d", entry.getKey(), "Passed:", +entry.getValue().getPassed(), "Failed:", entry.getValue().getFailed());
            summary.append("\n");
            passed += entry.getValue().getPassed();
            failed += entry.getValue().getFailed();
        }

        summary.append(new String(new char[76]).replace("\0", "="));
        summary.append("\n");
        formatter.format("%-50s%10s%3d%10s%3d", "TOTAL", "Passed:", +passed, "Failed:", failed);

        return summary.toString();
    }

    private class Results {

        private int passed = 0;
        private int failed = 0;

        public int getPassed() {
            return passed;
        }

        public int getFailed() {
            return failed;
        }

        public void Passed() {
            this.passed++;
        }

        public void Failed() {
            this.failed++;
        }
    }
}
