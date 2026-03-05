<h1 align="center">📦 Sistema de Controle de Estoque</h1>

<p align="center">
Sistema web para <b>controle de matérias-primas e planejamento de produção</b>
com base no estoque disponível.
</p>

<p align="center">
A aplicação gerencia produtos e insumos, calculando a <b>capacidade produtiva</b>
e priorizando itens de <b>maior valor unitário</b> para otimizar o ROI.
</p>

<hr>

<h2>🏗️ Arquitetura</h2>

<p>O projeto utiliza uma arquitetura desacoplada com comunicação via <b>API REST</b>.</p>

<ul>
<li><b>Backend:</b> Spring Boot 4.0.3 (Java 25)</li>
<li><b>Frontend:</b> Angular 21 (Material + TailwindCSS)</li>
<li><b>Database:</b> PostgreSQL 18</li>
<li><b>Autenticação:</b> Keycloak (OpenID Connect)</li>
<li><b>Infraestrutura:</b> Docker & Docker Compose</li>
</ul>

<hr>

<h2>⚙️ Tecnologias</h2>

<h3>Backend</h3>

<ul>
<li>Spring Boot 4.0.3</li>
<li>Java 25 (Eclipse Temurin)</li>
<li>Spring Data JPA / Hibernate</li>
<li>Flyway (migrations)</li>
<li>Spring Security</li>
<li>Springdoc OpenAPI</li>
<li>JUnit 5</li>
<li>Rest-Assured</li>
</ul>

<h3>Frontend</h3>

<ul>
<li>Angular 21.2</li>
<li>Angular Material</li>
<li>TailwindCSS 4</li>
<li>Keycloak JS Adapter</li>
<li>Vitest</li>
</ul>

<hr>

<h2>🔐 Autenticação</h2>

<p>
A aplicação utiliza <b>Keycloak</b> para autenticação e autorização,
seguindo o padrão <b>OpenID Connect (OIDC)</b>.
</p>

<p>
Todas as rotas da API (prefixo <code>/api</code>) são protegidas
e exigem um <b>access token JWT</b> válido emitido pelo Keycloak.
</p>

<h3>Usuário padrão de teste</h3>

<p>
Após subir a aplicação com Docker, um usuário de teste para acessar a aplicação é criado automaticamente:
</p>

<ul>
<li><b>Usuário:</b> teste</li>
<li><b>Senha:</b> teste</li>
</ul>

<h3>Acesso ao Keycloak</h3>

<pre>
http://localhost:8081
</pre>

<ul>
<li><b>Realm:</b> stock-control</li>
<li><b>Client Frontend:</b> stock-control-web</li>
<li><b>Client API:</b> stock-control-api</li>
</ul>

<hr>

<h2>🔗 Endpoints Principais</h2>

<p>A API responde no prefixo <code>/api</code>.</p>

<table>
<tr>
<th>Método</th>
<th>Endpoint</th>
<th>Descrição</th>
</tr>

<tr>
<td><b>GET</b></td>
<td><code>/api/products</code></td>
<td>Lista todos os produtos</td>
</tr>

<tr>
<td><b>GET</b></td>
<td><code>/api/products/{id}</code></td>
<td>Busca um produto pelo ID</td>
</tr>

<tr>
<td><b>POST</b></td>
<td><code>/api/products</code></td>
<td>Cadastra um novo produto</td>
</tr>

<tr>
<td><b>PUT</b></td>
<td><code>/api/products/{id}</code></td>
<td>Atualiza um produto existente</td>
</tr>

<tr>
<td><b>DELETE</b></td>
<td><code>/api/products/{id}</code></td>
<td>Remove um produto</td>
</tr>

<tr>
<td><b>GET</b></td>
<td><code>/api/products/production-suggestions</code></td>
<td>Retorna sugestões de produção priorizando produtos de maior valor</td>
</tr>

<tr>
<td><b>GET</b></td>
<td><code>/api/raw-materials</code></td>
<td>Lista o estoque de matérias-primas</td>
</tr>

<tr>
<td><b>GET</b></td>
<td><code>/api/raw-materials/{id}</code></td>
<td>Busca uma matéria-prima pelo ID</td>
</tr>

<tr>
<td><b>POST</b></td>
<td><code>/api/raw-materials</code></td>
<td>Cadastra uma nova matéria-prima</td>
</tr>

<tr>
<td><b>PUT</b></td>
<td><code>/api/raw-materials/{id}</code></td>
<td>Atualiza uma matéria-prima existente</td>
</tr>

<tr>
<td><b>DELETE</b></td>
<td><code>/api/raw-materials/{id}</code></td>
<td>Remove uma matéria-prima</td>
</tr>

</table>

<hr>

<h2>📑 Documentação da API</h2>

<p>
Após iniciar a aplicação, a documentação interativa da API (Swagger UI)
estará disponível em:
</p>

<pre>
http://localhost:8080/api/swagger-ui/index.html
</pre>

<hr>

<h2>🚀 Como Executar</h2>

<h3>Pré-requisitos</h3>

<ul>
<li>Docker & Docker Compose</li>
<li>Node.js / NPM (para desenvolvimento do frontend)</li>
<li>Maven / JDK 25 (para desenvolvimento do backend)</li>
</ul>

<h3>1) Clonar o projeto</h3>

<pre>
git clone &lt;repository-url&gt;
cd stock-control
</pre>

<h3>2) Criar arquivo de ambiente</h3>

<p>Na raiz do projeto, utilize o arquivo de exemplo:</p>

<pre>
cp .env.example .env
</pre>

<h3>3) Subir a aplicação</h3>

<pre>
docker compose up --build
</pre>

<p>Após iniciar:</p>

<ul>
<li><b>Frontend:</b> http://localhost:4200</li>
<li><b>Backend API:</b> http://localhost:8080/api</li>
<li><b>Swagger UI:</b> http://localhost:8080/api/swagger-ui/index.html</li>
<li><b>Keycloak:</b> http://localhost:8081</li>
</ul>

<hr>

<h2>🧪 Testes Automatizados</h2>

<pre>
docker compose -f docker-compose-test.yml up --build --abort-on-container-exit
</pre>

<hr>

<h2>📈 Regra de Negócio: Otimização de Produção</h2>

<ul>
<li><b>Análise de Estoque:</b> verifica a disponibilidade de cada <code>RawMaterial</code> vinculado ao <code>Product</code>.</li>
<li><b>Cálculo de Capacidade:</b> determina o gargalo de produção.</li>
<li><b>Priorização Financeira:</b> ordena as sugestões pelo maior preço de venda.</li>
</ul>

<p>
<b>Objetivo:</b> garantir que insumos limitados sejam utilizados primeiro
nos produtos com maior retorno financeiro.
</p>

<hr>

<h2>📄 Licença</h2>

<p>Projeto demonstrativo para estudo e referência.</p>

<p><b>Autor:</b> Alex Junior Mahia Amaral</p>