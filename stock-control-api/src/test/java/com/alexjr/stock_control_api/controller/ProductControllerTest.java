package com.alexjr.stock_control_api.controller;

import com.alexjr.stock_control_api.repository.ProductRepository;
import com.alexjr.stock_control_api.repository.RawMaterialRepository;
import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;
import org.springframework.transaction.annotation.Transactional;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;
import static org.junit.jupiter.api.Assertions.assertTrue;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class ProductControllerTest {

    @LocalServerPort
    private int port;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private RawMaterialRepository rawMaterialRepository;

    @BeforeEach
    void setup() {
        RestAssured.port = port;
        RestAssured.basePath = "/api";
        cleanDatabase();
    }

    @Transactional
    void cleanDatabase() {
        productRepository.deleteAll();
        rawMaterialRepository.deleteAll();
    }

    private static Long extractId(Object id) {
        return ((Number) id).longValue();
    }

    @Test
    void shouldCreateProduct() {
        Long rawMaterialId = extractId(
                given()
                        .contentType(ContentType.JSON)
                        .body("""
                            {
                              "code": "RM-T1",
                              "name": "Material Test",
                              "quantity": 20
                            }
                        """)
                        .when()
                        .post("/raw-materials")
                        .then()
                        .statusCode(anyOf(is(201), is(200)))
                        .extract()
                        .path("id")
        );

        given()
                .contentType(ContentType.JSON)
                .body("""
                    {
                      "code": "P-T1",
                      "name": "Test Product",
                      "price": 50.00,
                      "materials": [
                        { "rawMaterialId": %d, "quantity": 2 }
                      ]
                    }
                """.formatted(rawMaterialId))
                .when()
                .post("/products")
                .then()
                .statusCode(201)
                .body("id", notNullValue())
                .body("code", equalTo("P-T1"));
    }

    @Test
    void shouldReturn404WhenProductNotFound() {
        given()
                .when()
                .get("/products/999999")
                .then()
                .statusCode(404);
    }

    @Test
    void shouldCalculateProductionCorrectly() {
        Long rmId = extractId(
                given()
                        .contentType(ContentType.JSON)
                        .body("""
                            {
                              "code": "RM-T2",
                              "name": "Material Production",
                              "quantity": 10
                            }
                        """)
                        .when()
                        .post("/raw-materials")
                        .then()
                        .statusCode(anyOf(is(201), is(200)))
                        .extract()
                        .path("id")
        );

        given()
                .contentType(ContentType.JSON)
                .body("""
                    {
                      "code": "P-T2",
                      "name": "Production Product",
                      "price": 100.00,
                      "materials": [
                        { "rawMaterialId": %d, "quantity": 2 }
                      ]
                    }
                """.formatted(rmId))
                .when()
                .post("/products")
                .then()
                .statusCode(201);

        given()
                .when()
                .get("/products/production-suggestions")
                .then()
                .statusCode(200)
                .body("suggestions.find { it.productCode == 'P-T2' }.quantityToProduce", equalTo(5))
                .body("suggestions.find { it.productCode == 'P-T2' }.subtotal", is(500.0f))
                .body("totalEstimatedValue", notNullValue());
    }

    @Test
    void shouldPrioritizeHigherValueProduct() {
        Long rmId = extractId(
                given()
                        .contentType(ContentType.JSON)
                        .body("""
                            {
                              "code": "RM-T3",
                              "name": "Material Priority",
                              "quantity": 10
                            }
                        """)
                        .when()
                        .post("/raw-materials")
                        .then()
                        .statusCode(anyOf(is(201), is(200)))
                        .extract()
                        .path("id")
        );

        given()
                .contentType(ContentType.JSON)
                .body("""
                    {
                      "code": "P-HIGH",
                      "name": "High Product",
                      "price": 100.00,
                      "materials": [
                        { "rawMaterialId": %d, "quantity": 5 }
                      ]
                    }
                """.formatted(rmId))
                .when()
                .post("/products")
                .then()
                .statusCode(201);

        given()
                .contentType(ContentType.JSON)
                .body("""
                    {
                      "code": "P-LOW",
                      "name": "Low Product",
                      "price": 10.00,
                      "materials": [
                        { "rawMaterialId": %d, "quantity": 5 }
                      ]
                    }
                """.formatted(rmId))
                .when()
                .post("/products")
                .then()
                .statusCode(201);

        var json =
                given()
                        .when()
                        .get("/products/production-suggestions")
                        .then()
                        .statusCode(200)
                        .extract()
                        .jsonPath();

        int highIndex = json.getInt("suggestions.findIndexOf { it.productCode == 'P-HIGH' }");
        Object cheapProduct = json.get("suggestions.find { it.productCode == 'P-LOW' }");

        assertTrue(highIndex >= 0, "P-HIGH not found in suggestions");
        assertTrue(cheapProduct == null, "P-LOW should not be suggested when stock is consumed");

        int highQty = json.getInt("suggestions.find { it.productCode == 'P-HIGH' }.quantityToProduce");
        assertTrue(highQty == 2, "Expected P-HIGH quantityToProduce to be 2");
    }
}