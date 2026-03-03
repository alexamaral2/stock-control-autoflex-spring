package com.alexjr.stock_control_api.controller;

import io.restassured.RestAssured;
import io.restassured.http.ContentType;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.web.server.LocalServerPort;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
class RawMaterialControllerTest {

    @LocalServerPort
    private int port;

    @BeforeEach
    void setup() {
        RestAssured.port = port;
        RestAssured.basePath = "/api";
    }

    private static Long extractId(Object id) {
        return ((Number) id).longValue();
    }

    @Test
    void shouldCreateUpdateAndDeleteRawMaterial() {
        String code = "RM-TEST-010";

        Long id = createRawMaterial(code, "Raw Material Test", 25);
        assertRawMaterialById(id, code);

        updateRawMaterial(id, code, "Raw Material Updated", 40);

        deleteRawMaterial(id);

        assertRawMaterialNotFound(id);
    }

    private Long createRawMaterial(String code, String name, int quantity) {
        Object id =
                given()
                        .contentType(ContentType.JSON)
                        .body("""
                            {
                              "code": "%s",
                              "name": "%s",
                              "quantity": %d
                            }
                        """.formatted(code, name, quantity))
                        .when()
                        .post("/raw-materials")
                        .then()
                        .statusCode(201)
                        .body("id", notNullValue())
                        .body("code", equalTo(code))
                        .body("name", equalTo(name))
                        .body("quantity", equalTo(quantity))
                        .extract()
                        .path("id");

        return extractId(id);
    }

    private void assertRawMaterialById(Long id, String expectedCode) {
        given()
                .when()
                .get("/raw-materials/{id}", id)
                .then()
                .statusCode(200)
                .body("id", equalTo(id.intValue()))
                .body("code", equalTo(expectedCode));
    }

    private void updateRawMaterial(Long id, String code, String newName, int newQuantity) {
        given()
                .contentType(ContentType.JSON)
                .body("""
                    {
                      "code": "%s",
                      "name": "%s",
                      "quantity": %d
                    }
                """.formatted(code, newName, newQuantity))
                .when()
                .put("/raw-materials/{id}", id)
                .then()
                .statusCode(200)
                .body("id", notNullValue())
                .body("code", equalTo(code))
                .body("name", equalTo(newName))
                .body("quantity", equalTo(newQuantity));
    }

    private void deleteRawMaterial(Long id) {
        given()
                .when()
                .delete("/raw-materials/{id}", id)
                .then()
                .statusCode(204);
    }

    private void assertRawMaterialNotFound(Long id) {
        given()
                .when()
                .get("/raw-materials/{id}", id)
                .then()
                .statusCode(404);
    }
}