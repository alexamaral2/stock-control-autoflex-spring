INSERT INTO raw_material (code, name, quantity) VALUES 
('RM001', 'Polietileno de Alta Densidade (PEAD)', 10000),
('RM002', 'Polipropileno (PP)', 8000),
('RM003', 'PVC Flexível', 5000),
('RM004', 'ABS Industrial', 4000),
('RM005', 'Policarbonato Cristal', 2000),
('RM006', 'Pigmento Azul Masterbatch', 500),
('RM007', 'Pigmento Branco Dióxido de Titânio', 500),
('RM008', 'Aditivo Anti-UV', 200),
('RM009', 'Fibra de Vidro (Reforço)', 1500),
('RM010', 'Elastômero (TPE)', 2500);

INSERT INTO product (code, name, price) VALUES 
('PRD001', 'Garrafa Térmica 1L Azul', 45.90),
('PRD002', 'Organizador de Gaveta Transparente', 12.50),
('PRD003', 'Kit 4 Potes Herméticos PP', 89.00),
('PRD004', 'Cano de PVC 100mm (Metro)', 25.00),
('PRD005', 'Capacete de Segurança Industrial', 120.00),
('PRD006', 'Painel de Ar-Condicionado', 215.50),
('PRD007', 'Lente de Proteção Policarbonato', 35.00),
('PRD008', 'Cabo Ergonômico Emborrachado', 18.90),
('PRD009', 'Caixa Organizadora 50L Reforçada', 75.00),
('PRD010', 'Cadeira de Jardim Branca', 55.00);

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 250 FROM product p, raw_material rm WHERE p.name = 'Garrafa Térmica 1L Azul' AND rm.name = 'Polipropileno (PP)';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 5 FROM product p, raw_material rm WHERE p.name = 'Garrafa Térmica 1L Azul' AND rm.name = 'Pigmento Azul Masterbatch';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 150 FROM product p, raw_material rm WHERE p.name = 'Organizador de Gaveta Transparente' AND rm.name = 'Polipropileno (PP)';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 600 FROM product p, raw_material rm WHERE p.name = 'Kit 4 Potes Herméticos PP' AND rm.name = 'Polietileno de Alta Densidade (PEAD)';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 10 FROM product p, raw_material rm WHERE p.name = 'Kit 4 Potes Herméticos PP' AND rm.name = 'Pigmento Branco Dióxido de Titânio';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 450 FROM product p, raw_material rm WHERE p.name = 'Capacete de Segurança Industrial' AND rm.name = 'ABS Industrial';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 8 FROM product p, raw_material rm WHERE p.name = 'Capacete de Segurança Industrial' AND rm.name = 'Aditivo Anti-UV';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 800 FROM product p, raw_material rm WHERE p.name = 'Painel de Ar-Condicionado' AND rm.name = 'ABS Industrial';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 200 FROM product p, raw_material rm WHERE p.name = 'Painel de Ar-Condicionado' AND rm.name = 'Fibra de Vidro (Reforço)';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 70 FROM product p, raw_material rm WHERE p.name = 'Cabo Ergonômico Emborrachado' AND rm.name = 'Polipropileno (PP)';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 30 FROM product p, raw_material rm WHERE p.name = 'Cabo Ergonômico Emborrachado' AND rm.name = 'Elastômero (TPE)';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 2200 FROM product p, raw_material rm WHERE p.name = 'Cadeira de Jardim Branca' AND rm.name = 'Polietileno de Alta Densidade (PEAD)';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 50 FROM product p, raw_material rm WHERE p.name = 'Cadeira de Jardim Branca' AND rm.name = 'Pigmento Branco Dióxido de Titânio';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 15 FROM product p, raw_material rm WHERE p.name = 'Cadeira de Jardim Branca' AND rm.name = 'Aditivo Anti-UV';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 1000 FROM product p, raw_material rm WHERE p.name = 'Cano de PVC 100mm (Metro)' AND rm.name = 'PVC Flexível';

INSERT INTO product_raw_material (product_id, raw_material_id, quantity) 
SELECT p.id, rm.id, 80 FROM product p, raw_material rm WHERE p.name = 'Lente de Proteção Policarbonato' AND rm.name = 'Policarbonato Cristal';