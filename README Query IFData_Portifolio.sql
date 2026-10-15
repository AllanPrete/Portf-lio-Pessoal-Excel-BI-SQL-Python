/*
======================================================================
  ANALISTA JUNIOR COM IA -- Modulo 4: SQL
  Arquivo de pratica: IF.data -- Banco Central do Brasil
  Dados de referencia: Setembro/2025
  Valores monetarios em R$ mil

  COMO USAR:
  1. Execute a PARTE 1 (Setup) para criar as tabelas
  2. Execute a PARTE 2 (Dados) para inserir os registros
  3. Execute a PARTE 3 (Verificacao) para confirmar o carregamento
  4. Pratique os Exemplos da PARTE 4
  5. Resolva os Exercicios da PARTE 5
  6. Compare com o Gabarito da PARTE 6
  7. Use a Analise Final da PARTE 7 para o projeto do modulo

  COMPATIBILIDADE: PostgreSQL (recomendado) / Supabase
  Para SQLite: substitua SERIAL por INTEGER, remova :: e use CAST()
  Para MySQL:  substitua SERIAL por AUTO_INCREMENT

  NOTA: Este arquivo usa dados reais do sistema financeiro brasileiro.
  A base IF.data esta disponivel em: https://www3.bcb.gov.br/ifdata
*/


-- ====================================================================
-- PARTE 1 -- SETUP: CRIACAO DAS TABELAS
-- ====================================================================

-- Limpar tabelas se ja existirem
DROP TABLE IF EXISTS estrutura;
DROP TABLE IF EXISTS financeiros;
DROP TABLE IF EXISTS instituicoes;

CREATE TABLE instituicoes (
    id          SERIAL PRIMARY KEY,
    nome        VARCHAR(120) NOT NULL,
    codigo      VARCHAR(20),
    tcb         VARCHAR(10),  -- Tipo de Consolidado Bancario
    segmento    VARCHAR(5),   -- SR: S1=maior ... S5=menor
    controle    VARCHAR(2),   -- 1=Publico  2=Priv.Nac.  3=Priv.Ext.
    cidade      VARCHAR(80),
    uf          VARCHAR(2)
);

CREATE TABLE financeiros (
    id                  SERIAL PRIMARY KEY,
    inst_id             INTEGER REFERENCES instituicoes(id),
    data_ref            DATE NOT NULL,
    ativo_total         BIGINT,
    carteira_credito    BIGINT,
    tvm                 BIGINT,
    passivo_exigivel    BIGINT,
    captacoes           BIGINT,
    patrimonio_liquido  BIGINT,
    lucro_liquido       BIGINT
);

CREATE TABLE estrutura (
    id              SERIAL PRIMARY KEY,
    inst_id         INTEGER REFERENCES instituicoes(id),
    data_ref        DATE NOT NULL,
    num_agencias    INTEGER DEFAULT 0,
    num_postos      INTEGER DEFAULT 0
);


-- ====================================================================
-- PARTE 2 -- DADOS REAIS DO IF.DATA
-- 50 maiores instituicoes por Ativo Total -- Setembro/2025
-- Codigos TCB: b1=Banco Comercial  b4=Banco Desenvolvimento
--              n1=Nao Bancario Credito  n4=Instituicao Pagamento
-- Codigos SR:  S1=Sistemico ... S5=Menor porte
-- ====================================================================

INSERT INTO instituicoes (nome, codigo, tcb, segmento, controle, cidade, uf) VALUES
    ('BANCO NACIONAL DE DESENVOLVIMENTO ECONOMICO E SOCIAL', '33657248', 'b4', 'S2', '1', 'RIO DE JANEIRO', 'RJ'),
    ('BTG PACTUAL', '49944', 'b1', 'S1', '2', 'RIO DE JANEIRO', 'RJ'),
    ('XP', '52120', 'b1', 'S2', '2', 'RIO DE JANEIRO', 'RJ'),
    ('SAFRA', '10083', 'b1', 'S2', '2', 'SAO PAULO', 'SP'),
    ('NUBANK', '52058', 'n1', 'S2', '3', 'SAO PAULO', 'SP'),
    ('BANCO COOPERATIVO SICREDI S.A.', '1181521', 'b1', 'S2', '2', 'PORTO ALEGRE', 'RS'),
    ('BANCO SICOOB', '51750', 'b1', 'S2', '2', 'BRASILIA', 'DF'),
    ('CITIBANK', '30403', 'b1', 'S2', '3', 'SAO PAULO', 'SP'),
    ('BANRISUL', '30173', 'b1', 'S2', '1', 'PORTO ALEGRE', 'RS'),
    ('VOTORANTIM', '51011', 'b1', 'S2', '2', 'SAO PAULO', 'SP'),
    ('REDECARD INSTITUIÇÃO DE PAGAMENTO S.A.', '1425787', 'n4', 'S1', '2', 'SAO PAULO', 'SP'),
    ('C6 BANK', '52072', 'b1', 'S3', '2', 'SAO PAULO', 'SP'),
    ('CIELO S.A. - INSTITUIÇÃO DE PAGAMENTO', '1027058', 'n4', 'NA', '2', 'BARUERI', 'SP'),
    ('JP MORGAN CHASE', '20107', 'b1', 'S3', '3', 'SAO PAULO', 'SP'),
    ('NU PAGAMENTOS S.A. - INSTITUIÇÃO DE PAGAMENTO', '18236120', 'n4', 'S2', '3', 'SAO PAULO', 'SP'),
    ('DAYCOVAL', '51987', 'b1', 'S3', '2', 'SAO PAULO', 'SP'),
    ('INTER', '51884', 'b1', 'S3', '2', 'BELO HORIZONTE', 'MG'),
    ('MERCADO PAGO INSTITUIÇÃO DE PAGAMENTO LTDA.', '10573521', 'n4', 'S3', '3', 'OSASCO', 'SP'),
    ('BRB', '31976', 'b1', 'S3', '1', 'BRASILIA', 'DF'),
    ('STONE INSTITUIÇÃO DE PAGAMENTO S.A.', '16501555', 'n4', 'S3', '3', 'SAO PAULO', 'SP'),
    ('GETNET ADQUIRÊNCIA E SERVIÇOS PARA MEIOS DE PAGAMENTO S.A. INSTITUIÇÃO DE PAGAMENTO', '10440482', 'n4', 'S1', '3', 'SAO PAULO', 'SP'),
    ('BANCO DO NORDESTE DO BRASIL S.A.', '7237373', 'b1', 'S2', '1', 'FORTALEZA', 'CE'),
    ('PAGSEGURO INTERNET INSTITUIÇÃO DE PAGAMENTO S.A.', '8561701', 'n4', 'S3', '2', 'SAO PAULO', 'SP'),
    ('ABC-BRASIL', '41856', 'b1', 'S3', '3', 'SAO PAULO', 'SP'),
    ('BANCO DA AMAZONIA S.A.', '4902979', 'b1', 'S3', '1', 'BELEM', 'PA'),
    ('BANCO VOLKSWAGEN S.A.', '59109165', 'b2', 'S3', '3', 'SAO PAULO', 'SP'),
    ('BANCO BNP PARIBAS BRASIL S.A.', '1522368', 'b1', 'S3', '3', 'SAO PAULO', 'SP'),
    ('BANCO RABOBANK INTERNATIONAL BRASIL S.A.', '1023570', 'b1', 'S3', '3', 'SAO PAULO', 'SP'),
    ('BMG', '30290', 'b1', 'S3', '2', 'SAO PAULO', 'SP'),
    ('PAGBANK-PAGSEGURO', '52182', 'b1', 'S3', '2', 'SAO PAULO', 'SP'),
    ('AGIBANK', '51956', 'b1', 'S3', '2', 'CAMPINAS', 'SP'),
    ('BOFA MERRILL LYNCH', '51255', 'b1', 'S3', '3', 'SAO PAULO', 'SP'),
    ('BANESTES', '30159', 'b1', 'S3', '1', 'VITORIA', 'ES'),
    ('PICPAY - FINANCEIRO', '52632', 'b1', 'S3', '2', 'SAO PAULO', 'SP'),
    ('GOLDMAN SACHS', '51585', 'b2', 'S3', '3', 'SAO PAULO', 'SP'),
    ('BANCO CLASSICO S.A.', '31597552', 'b1', 'S3', '2', 'RIO DE JANEIRO', 'RJ'),
    ('BANCO ORIGINAL S.A.', '92894922', 'b1', 'S3', '2', 'SAO PAULO', 'SP'),
    ('MERCANTIL DO BRASIL', '20152', 'b1', 'S3', '2', 'BELO HORIZONTE', 'MG'),
    ('COOPERATIVA CENTRAL DE CRÉDITO DE MINAS GERAIS LTDA. - SICOOB CENTRAL CREDIMINAS', '25683434', 'b3C', 'S3', '2', 'BELO HORIZONTE', 'MG'),
    ('PINE', '50304', 'b1', 'S3', '2', 'SAO PAULO', 'SP'),
    ('TERRA', '52113', 'n2', 'S4', '2', 'SAO PAULO', 'SP'),
    ('BOCOM', '52003', 'b1', 'S3', '3', 'SALVADOR', 'BA'),
    ('BANCO REGIONAL DE DESENVOLVIMENTO DO EXTREMO SUL', '92816560', 'b4', 'S3', '1', 'PORTO ALEGRE', 'RS'),
    ('BANCO CNH INDUSTRIAL CAPITAL S.A.', '2992446', 'b2', 'S3', '3', 'CURITIBA', 'PR'),
    ('STONE SOCIEDADE DE CREDITO, FINANCIAMENTO E INVESTIMENTO S.A.', '53505601', 'n1', 'S3', '3', 'SAO PAULO', 'SP'),
    ('STELLANTIS', '52508', 'b2', 'S3', '3', 'SAO PAULO', 'SP'),
    ('CLOUDWALK INSTITUIÇÃO DE PAGAMENTO E SERVICOS LTDA', '18189547', 'n4', 'S4', '2', 'SAO PAULO', 'SP'),
    ('CENTRAL DAS COOPERATIVAS DE ECONOMIA E CREDITO DO ESTADO DE MINAS GERAIS LTDA. - SICOOB CENTRAL CECR', '309024', 'b3C', 'S3', '2', 'BELO HORIZONTE', 'MG'),
    ('BANCO CSF S.A.', '8357240', 'b2', 'S3', '2', 'SAO PAULO', 'SP'),
    ('COOPERATIVA CENTRAL DE CRÉDITO DE SANTA CATARINA E RIO GRANDE DO SUL - SICOOB CENTRAL SC/RS', '80160260', 'b3C', 'S3', '2', 'FLORIANOPOLIS', 'SC');

INSERT INTO financeiros
    (inst_id, data_ref, ativo_total, carteira_credito, tvm,
     passivo_exigivel, captacoes, patrimonio_liquido, lucro_liquido)
VALUES
    (1, '2025-09-01', 905220074, 337101530, 163600304, 736690922, 596672518, 168529152, 3897466),
    (2, '2025-09-01', 665445894, 168426944, 205485096, 597330797, 460048347, 68115098, 4337377),
    (3, '2025-09-01', 307101659, 33329722, 109000669, 294990308, 219008553, 12111351, 205279),
    (4, '2025-09-01', 271094929, 132708479, 69307857, 252005262, 207723576, 19089667, 1128996),
    (5, '2025-09-01', 219449385, 61661647, 65169820, 207181651, 186790022, 12267733, 2198336),
    (6, '2025-09-01', 218490737, 42609275, 57996229, 213011964, 188480581, 5478773, 15778),
    (7, '2025-09-01', 201784998, 38031688, 41539239, 196149070, 172714942, 5635928, 135356),
    (8, '2025-09-01', 200077288, 31540925, 50921410, 185601125, 153215374, 14476163, 900878),
    (9, '2025-09-01', 158217683, 60523673, 66985961, 147341800, 135080299, 10875884, 328616),
    (10, '2025-09-01', 149358844, 73288335, 37221208, 136468541, 110051230, 12890303, 457848),
    (11, '2025-09-01', 137122969, NULL, 8287550, 98343078, 1478, 38779891, 917240),
    (12, '2025-09-01', 134136879, 81749998, 34316499, 128508996, 93233153, 5627883, 634846),
    (13, '2025-09-01', 114886546, NULL, 9277619, 104649265, 10716782, 10237281, 343972),
    (14, '2025-09-01', 108602030, 2123945, 46332669, 95483657, 80007018, 13118373, 553831),
    (15, '2025-09-01', 103307891, 61461123, 616461, 83974937, 8385269, 19332954, 2902783),
    (16, '2025-09-01', 90792081, 52257443, 20464231, 82811660, 73619583, 7980420, 473258),
    (17, '2025-09-01', 89798255, 39109757, 26898298, 82451334, 69019589, 7346921, 288276),
    (18, '2025-09-01', 83811718, 15083268, 12474813, 80429749, 38886398, 3381969, 225790),
    (19, '2025-09-01', 81653988, 54825544, 13858351, 77133167, 69274647, 4520820, 184060),
    (20, '2025-09-01', 81421286, NULL, 28893421, 78709548, 29062647, 2711738, 94102),
    (21, '2025-09-01', 75739273, NULL, 114927, 72438692, 545506, 3300581, 124935),
    (22, '2025-09-01', 71183557, 18694576, 43688126, 55662219, 21820106, 15521338, 657843),
    (23, '2025-09-01', 70658099, 570898, 4812581, 61347060, 43152758, 9311040, 241167),
    (24, '2025-09-01', 61037531, 20697873, 27404725, 54321463, 46150549, 6716068, 263010),
    (25, '2025-09-01', 60398229, 35935979, 20362942, 53115179, 14740265, 7283049, 224768),
    (26, '2025-09-01', 57305530, 47227707, 411875, 52194555, 45679270, 5110975, 52127),
    (27, '2025-09-01', 53861163, 6435562, 25019318, 49130639, 34576722, 4730524, -14272),
    (28, '2025-09-01', 53243129, 35929923, 5428626, 47436684, 42473991, 5806445, 133564),
    (29, '2025-09-01', 48654470, 21826968, 16044068, 44808273, 34121921, 3846197, 148265),
    (30, '2025-09-01', 47121104, 42705618, 350110, 45731566, 45436982, 1389538, 12156),
    (31, '2025-09-01', 46039242, 32156062, 8673021, 42980647, 30299489, 3058595, 222644),
    (32, '2025-09-01', 39477159, 2319542, 9631104, 32577440, 22798787, 6899720, 254132),
    (33, '2025-09-01', 39224908, 12030223, 10490646, 36782556, 35293616, 2442351, 110665),
    (34, '2025-09-01', 36903126, 18692150, 9101147, 35579849, 28066944, 1323278, 44142),
    (35, '2025-09-01', 35476399, NULL, 21278861, 30529349, 14735766, 4947050, 236535),
    (36, '2025-09-01', 35077310, NULL, 29886789, 16040614, 4622609, 19036696, 68896),
    (37, '2025-09-01', 33578473, 13581188, 11511218, 32114297, 29988027, 1464177, -14250),
    (38, '2025-09-01', 32632191, 20505840, 2391464, 30344679, 26259364, 2287511, 254936),
    (39, '2025-09-01', 31721175, 138917, 7343431, 30129225, 948743, 1591950, 10863),
    (40, '2025-09-01', 30739948, 12152152, 13824642, 29490244, 23758737, 1249704, 103633),
    (41, '2025-09-01', 30330849, NULL, 142312, 30244562, 1318842, 86287, 3610),
    (42, '2025-09-01', 28400226, 14361419, 8435205, 26790924, 23887933, 1609302, 142429),
    (43, '2025-09-01', 28240633, 22929973, 4565489, 22831876, 21388428, 5408758, 159410),
    (44, '2025-09-01', 27234386, 23527547, 19369, 24481925, 22550223, 2752461, -155379),
    (45, '2025-09-01', 26159000, 22491450, NULL, 25964210, 25441979, 194789, 38794),
    (46, '2025-09-01', 23376337, 19250467, 1472989, 19339832, 18003645, 4036505, 159661),
    (47, '2025-09-01', 23208647, NULL, 607961, 21756217, 1254756, 1452431, 178745),
    (48, '2025-09-01', 22431780, 1004993, 5253323, 21513750, NULL, 918030, 37859),
    (49, '2025-09-01', 22051633, 17261498, 935697, 19007043, 3868153, 3044590, 97927),
    (50, '2025-09-01', 21876586, 213116, 4099642, 20448056, 693241, 1428530, 37941);

INSERT INTO estrutura (inst_id, data_ref, num_agencias, num_postos) VALUES
    (1, '2025-09-01', 5, 0),
    (2, '2025-09-01', 66, 0),
    (3, '2025-09-01', 11, 0),
    (4, '2025-09-01', 188, 3),
    (5, '2025-09-01', 4, 0),
    (6, '2025-09-01', 6, 0),
    (7, '2025-09-01', 7, 0),
    (8, '2025-09-01', 53, 8),
    (9, '2025-09-01', 514, 43),
    (10, '2025-09-01', 7, 3),
    (11, '2025-09-01', 1, 0),
    (12, '2025-09-01', 6, 0),
    (13, '2025-09-01', 1, 0),
    (14, '2025-09-01', 9, 0),
    (15, '2025-09-01', 1, 0),
    (16, '2025-09-01', 60, 0),
    (17, '2025-09-01', 4, 0),
    (18, '2025-09-01', 1, 0),
    (19, '2025-09-01', 69, 193),
    (20, '2025-09-01', 1, 0),
    (21, '2025-09-01', 1, 0),
    (22, '2025-09-01', 301, 1),
    (23, '2025-09-01', 1, 0),
    (24, '2025-09-01', 15, 0),
    (25, '2025-09-01', 115, 0),
    (26, '2025-09-01', 2, 0),
    (27, '2025-09-01', 2, 0),
    (28, '2025-09-01', 19, 0),
    (29, '2025-09-01', 35, 2),
    (30, '2025-09-01', 4, 0),
    (31, '2025-09-01', 4, 318),
    (32, '2025-09-01', 3, 0),
    (33, '2025-09-01', 88, 62),
    (34, '2025-09-01', 7, 0),
    (35, '2025-09-01', 4, 0),
    (36, '2025-09-01', 2, 0),
    (37, '2025-09-01', 2, 0),
    (38, '2025-09-01', 11, 298),
    (39, '2025-09-01', 0, 0),
    (40, '2025-09-01', 5, 0),
    (41, '2025-09-01', 6, 0),
    (42, '2025-09-01', 8, 0),
    (43, '2025-09-01', 4, 0),
    (44, '2025-09-01', 2, 0),
    (45, '2025-09-01', 2, 0),
    (46, '2025-09-01', 4, 0),
    (47, '2025-09-01', 1, 0),
    (48, '2025-09-01', 0, 0),
    (49, '2025-09-01', 2, 0),
    (50, '2025-09-01', 0, 0);


-- ====================================================================
-- PARTE 3 -- VERIFICACAO
-- ====================================================================

SELECT 'instituicoes' AS tabela, COUNT(*) AS registros FROM instituicoes
UNION ALL
SELECT 'financeiros',  COUNT(*) FROM financeiros
UNION ALL
SELECT 'estrutura',    COUNT(*) FROM estrutura;
-- Esperado: 50 registros em cada tabela

SELECT * FROM instituicoes ORDER BY id LIMIT 5;
SELECT * FROM financeiros  ORDER BY id LIMIT 5;
SELECT * FROM estrutura    ORDER BY id LIMIT 5;


-- ====================================================================
-- PARTE 4 -- EXEMPLOS DO MODULO
-- Execute um a um e observe os resultados
-- ====================================================================

-- ------------------------------------------------------------
-- Exemplo 1 -- SELECT / FROM / WHERE -- Listar instituicoes publicas
-- ------------------------------------------------------------

SELECT
    nome,
    segmento,
    uf
FROM instituicoes
WHERE controle = '1'  -- 1 = Publico
ORDER BY nome;


-- ------------------------------------------------------------
-- Exemplo 2 -- WHERE com AND -- S1 em SP
-- ------------------------------------------------------------

SELECT
    nome,
    tcb,
    cidade
FROM instituicoes
WHERE segmento = 'S1'
  AND uf = 'SP';


-- ------------------------------------------------------------
-- Exemplo 3 -- WHERE com IN -- varios valores
-- ------------------------------------------------------------

SELECT
    nome,
    segmento,
    controle
FROM instituicoes
WHERE segmento IN ('S1', 'S2')
  AND controle != '1';  -- exclui publicos


-- ------------------------------------------------------------
-- Exemplo 4 -- GROUP BY + COUNT -- contar por segmento
-- ------------------------------------------------------------

SELECT
    segmento,
    COUNT(*) AS total_instituicoes
FROM instituicoes
WHERE segmento IS NOT NULL
GROUP BY segmento
ORDER BY total_instituicoes DESC;


-- ------------------------------------------------------------
-- Exemplo 5 -- GROUP BY + JOIN -- somar ativo por controle
-- ------------------------------------------------------------

SELECT
    i.controle,
    COUNT(*)                AS qtd,
    SUM(f.ativo_total)      AS ativo_soma,
    AVG(f.ativo_total)      AS ativo_medio,
    MAX(f.ativo_total)      AS maior_ativo
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
GROUP BY i.controle
ORDER BY ativo_soma DESC;


-- ------------------------------------------------------------
-- Exemplo 6 -- HAVING -- segmentos com mais de 5 instituicoes
-- ------------------------------------------------------------

SELECT
    segmento,
    COUNT(*) AS total
FROM instituicoes
GROUP BY segmento
HAVING COUNT(*) > 5
ORDER BY total DESC;


-- ------------------------------------------------------------
-- Exemplo 7 -- ORDER BY + LIMIT -- top 10 por ativo
-- ------------------------------------------------------------

SELECT
    i.nome,
    i.segmento,
    i.controle,
    f.ativo_total
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
ORDER BY f.ativo_total DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Exemplo 8 -- INNER JOIN -- mais de 100 agencias
-- ------------------------------------------------------------

SELECT
    i.nome,
    i.uf,
    i.segmento,
    e.num_agencias,
    e.num_postos
FROM instituicoes i
INNER JOIN estrutura e ON e.inst_id = i.id
WHERE e.data_ref = '2025-09-01'
  AND e.num_agencias > 100
ORDER BY e.num_agencias DESC;


-- ------------------------------------------------------------
-- Exemplo 9 -- LEFT JOIN -- sem dados financeiros
-- ------------------------------------------------------------

SELECT
    i.nome,
    i.segmento,
    f.ativo_total
FROM instituicoes i
LEFT JOIN financeiros f
    ON f.inst_id = i.id
    AND f.data_ref = '2025-09-01'
WHERE f.inst_id IS NULL;
-- Resultado esperado: nenhum registro (todos tem dados)


-- ------------------------------------------------------------
-- Exemplo 10 -- JOIN triplo -- tres tabelas
-- ------------------------------------------------------------

SELECT
    i.nome,
    i.segmento,
    i.controle,
    f.ativo_total,
    f.carteira_credito,
    f.lucro_liquido,
    e.num_agencias
FROM instituicoes i
INNER JOIN financeiros f ON f.inst_id = i.id
INNER JOIN estrutura e  ON e.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND e.data_ref = '2025-09-01'
  AND i.segmento IN ('S1', 'S2')
ORDER BY f.ativo_total DESC;


-- ------------------------------------------------------------
-- Exemplo 11 -- Subconsulta -- acima da media
-- ------------------------------------------------------------

SELECT
    i.nome,
    f.ativo_total
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND f.ativo_total > (
      SELECT AVG(ativo_total)
      FROM financeiros
      WHERE data_ref = '2025-09-01'
  )
ORDER BY f.ativo_total DESC;


-- ------------------------------------------------------------
-- Exemplo 12 -- CTE (WITH) -- calcular e classificar ROE
-- ------------------------------------------------------------

WITH base AS (
    SELECT
        i.nome,
        i.segmento,
        i.controle,
        ROUND(
            CAST(f.lucro_liquido AS NUMERIC)
            / NULLIF(f.patrimonio_liquido, 0) * 100, 2
        ) AS roe_pct
    FROM instituicoes i
    JOIN financeiros f ON f.inst_id = i.id
    WHERE f.data_ref = '2025-09-01'
      AND f.patrimonio_liquido > 0
)
SELECT
    nome, segmento, controle, roe_pct,
    CASE
        WHEN roe_pct > 15 THEN 'Excelente'
        WHEN roe_pct > 8  THEN 'Bom'
        WHEN roe_pct > 0  THEN 'Fraco'
        ELSE 'Prejuizo'
    END AS classificacao_roe
FROM base
ORDER BY roe_pct DESC;


-- ====================================================================
-- PARTE 5 -- EXERCICIOS PRATICOS
-- Escreva as queries abaixo. Gabarito na Parte 6.
-- Dica: use o Claude.ai para checar suas respostas.
-- ====================================================================

-- ------------------------------------------------------------
-- Exercicio 1 [SELECT, WHERE, ORDER BY]
-- ------------------------------------------------------------

Liste nome, segmento e UF de todas as instituicoes
-- de controle estrangeiro (controle = '3'), ordenadas por nome.

-- Sua query aqui:

select 
	nome,
	segmento,
	uf
from instituicoes
Where controle = '3'
order by nome


-- ------------------------------------------------------------
-- Exercicio 2 [GROUP BY, HAVING]
-- ------------------------------------------------------------

Conte quantas instituicoes existem por UF.
-- Mostre so as UFs com mais de 2 instituicoes.

-- Sua query aqui:

SELECT
    uf,
    COUNT(*) AS total
FROM instituicoes
GROUP BY uf
HAVING COUNT(*) > 2


-- ------------------------------------------------------------
-- Exercicio 3 [GROUP BY, SUM, AVG]
-- ------------------------------------------------------------

Qual a soma e a media do ativo_total por segmento?
-- Ordene do maior para o menor ativo somado.

-- Sua query aqui:

SELECT
    i.segmento,
    COUNT(*)            AS qtd,
    SUM(f.ativo_total)  AS ativo_soma,
    AVG(f.ativo_total)  AS ativo_medio
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND i.segmento IS NOT NULL
GROUP BY i.segmento
ORDER BY ativo_soma DESC;



-- ------------------------------------------------------------
-- Exercicio 4 [JOIN, ORDER BY, LIMIT]
-- ------------------------------------------------------------

Liste as 10 instituicoes com maior carteira_credito.
-- Inclua nome, segmento e controle.

-- Sua query aqui:

SELECT i.nome,
	i.segmento,
	i.controle,
	f.carteira_credito
FROM instituicoes as i
JOIN financeiros as f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
ORDER BY f.carteira_credito DESC
LIMIT 10



-- ------------------------------------------------------------
-- Exercicio 5 [JOIN, WHERE, SUM]
-- ------------------------------------------------------------

Quantas instituicoes tem num_agencias = 0?
-- Qual o ativo_total somado desse grupo?

-- Sua query aqui:

SELECT
    COUNT(*) as qtd_sem_agencia,
    SUM(f.ativo_total) as ativo_soma_total
FROM instituicoes as i
JOIN financeiros as f on f.inst_id = i.id
JOIN estrutura as e on e.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
AND e.data_ref = '2025-09-01'
AND e.num_agencias = 0;



-- ------------------------------------------------------------
-- Exercicio 6 [WITH, CASE]
-- ------------------------------------------------------------

Calcule o ROE de cada instituicao usando CTE.
-- Classifique como Excelente/Bom/Fraco/Prejuizo.

-- Sua query aqui:

WITH base AS (
    SELECT i.nome, i.segmento, i.controle,
           ROUND(
               CAST(f.lucro_liquido AS NUMERIC)
               / NULLIF(f.patrimonio_liquido, 0) * 100, 2
           ) AS roe_pct
    FROM instituicoes i
    JOIN financeiros f ON f.inst_id = i.id
    WHERE f.data_ref = '2025-09-01'
      AND f.patrimonio_liquido > 0
)
SELECT nome, segmento, controle, roe_pct,
    CASE WHEN roe_pct > 15 THEN 'Excelente'
         WHEN roe_pct > 8  THEN 'Bom'
         WHEN roe_pct > 0  THEN 'Fraco'
         ELSE 'Prejuizo' END AS classificacao_roe
FROM base ORDER BY roe_pct DESC;



-- ------------------------------------------------------------
-- Exercicio 7 [Subconsulta]
-- ------------------------------------------------------------

Encontre instituicoes com ativo_total acima da media
-- do proprio segmento.

-- Sua query aqui:

SELECT i.nome,
	i.segmento,
	f.ativo_total
FROM instituicoes as i
JOIN financeiros as f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND f.ativo_total > (
      SELECT AVG(f2.ativo_total)
      FROM financeiros as f2
      JOIN instituicoes as i2 ON i2.id = f2.inst_id
      WHERE f2.data_ref = '2025-09-01'
        AND i2.segmento = i.segmento
  )
ORDER BY i.segmento, f.ativo_total DESC;



-- ------------------------------------------------------------
-- Exercicio 8 [GROUP BY, COUNT, SUM, MAX, MIN]
-- ------------------------------------------------------------

Para cada segmento: qtd de instituicoes, soma de ativo,
-- maior lucro e menor lucro.

-- Sua query aqui:

SELECT
    i.segmento,
    COUNT(*) as qtd,
    SUM(f.ativo_total) as ativo_soma,
    MAX(f.lucro_liquido) as maior_lucro,
    MIN(f.lucro_liquido) as menor_lucro
FROM instituicoes as i
JOIN financeiros as f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01' AND i.segmento IS NOT NULL
GROUP BY i.segmento
ORDER BY ativo_soma DESC;



-- ------------------------------------------------------------
-- Exercicio 9 [WHERE, ORDER BY]
-- ------------------------------------------------------------

Liste instituicoes com lucro_liquido negativo (prejuizo),
-- do maior prejuizo ao menor.

-- Sua query aqui:

SELECT i.nome,
	i.segmento,
	f.lucro_liquido
FROM instituicoes as i
JOIN financeiros as f on f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND f.lucro_liquido < 0
ORDER BY f.lucro_liquido ASC;




-- ------------------------------------------------------------
-- Exercicio 10 [JOIN triplo, CTE]
-- ------------------------------------------------------------

Junte as 3 tabelas e traga: nome, segmento, controle,
-- ativo_total, carteira_credito, ROE e num_agencias
-- das instituicoes S1 e S2.

-- Sua query aqui:

WITH roe AS (
    SELECT inst_id,
           ROUND(CAST(lucro_liquido AS NUMERIC)
                 / NULLIF(patrimonio_liquido, 0) * 100, 2) AS roe_pct
    FROM financeiros WHERE data_ref = '2025-09-01'
)
SELECT i.nome, i.segmento, i.controle,
       f.ativo_total, f.carteira_credito,
       r.roe_pct, e.num_agencias
FROM instituicoes i
INNER JOIN financeiros f ON f.inst_id = i.id
INNER JOIN estrutura e  ON e.inst_id = i.id
INNER JOIN roe r        ON r.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND e.data_ref = '2025-09-01'
  AND i.segmento IN ('S1', 'S2')
ORDER BY f.ativo_total DESC;



-- ====================================================================
-- PARTE 6 -- GABARITO
-- Nao espie antes de tentar!
-- ====================================================================

-- ------------------------------------------------------------
-- Gabarito -- Exercicio 1
-- ------------------------------------------------------------

SELECT nome, segmento, uf
FROM instituicoes
WHERE controle = '3'
ORDER BY nome;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 2
-- ------------------------------------------------------------

SELECT uf, COUNT(*) AS total
FROM instituicoes
GROUP BY uf
HAVING COUNT(*) > 2
ORDER BY total DESC;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 3
-- ------------------------------------------------------------

SELECT
    i.segmento,
    COUNT(*)            AS qtd,
    SUM(f.ativo_total)  AS ativo_soma,
    AVG(f.ativo_total)  AS ativo_medio
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND i.segmento IS NOT NULL
GROUP BY i.segmento
ORDER BY ativo_soma DESC;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 4
-- ------------------------------------------------------------

SELECT i.nome, i.segmento, i.controle, f.carteira_credito
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
ORDER BY f.carteira_credito DESC
LIMIT 10;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 5
-- ------------------------------------------------------------

SELECT
    COUNT(*)            AS qtd_sem_agencia,
    SUM(f.ativo_total)  AS ativo_soma
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
JOIN estrutura e  ON e.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND e.data_ref = '2025-09-01'
  AND e.num_agencias = 0;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 6
-- ------------------------------------------------------------

WITH base AS (
    SELECT i.nome, i.segmento, i.controle,
           ROUND(
               CAST(f.lucro_liquido AS NUMERIC)
               / NULLIF(f.patrimonio_liquido, 0) * 100, 2
           ) AS roe_pct
    FROM instituicoes i
    JOIN financeiros f ON f.inst_id = i.id
    WHERE f.data_ref = '2025-09-01'
      AND f.patrimonio_liquido > 0
)
SELECT nome, segmento, controle, roe_pct,
    CASE WHEN roe_pct > 15 THEN 'Excelente'
         WHEN roe_pct > 8  THEN 'Bom'
         WHEN roe_pct > 0  THEN 'Fraco'
         ELSE 'Prejuizo' END AS classificacao_roe
FROM base ORDER BY roe_pct DESC;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 7
-- ------------------------------------------------------------

SELECT i.nome, i.segmento, f.ativo_total
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND f.ativo_total > (
      SELECT AVG(f2.ativo_total)
      FROM financeiros f2
      JOIN instituicoes i2 ON i2.id = f2.inst_id
      WHERE f2.data_ref = '2025-09-01'
        AND i2.segmento = i.segmento
  )
ORDER BY i.segmento, f.ativo_total DESC;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 8
-- ------------------------------------------------------------

SELECT
    i.segmento,
    COUNT(*)                AS qtd,
    SUM(f.ativo_total)      AS ativo_soma,
    MAX(f.lucro_liquido)    AS maior_lucro,
    MIN(f.lucro_liquido)    AS menor_lucro
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01' AND i.segmento IS NOT NULL
GROUP BY i.segmento
ORDER BY ativo_soma DESC;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 9
-- ------------------------------------------------------------

SELECT i.nome, i.segmento, f.lucro_liquido
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND f.lucro_liquido < 0
ORDER BY f.lucro_liquido ASC;


-- ------------------------------------------------------------
-- Gabarito -- Exercicio 10
-- ------------------------------------------------------------

WITH roe AS (
    SELECT inst_id,
           ROUND(CAST(lucro_liquido AS NUMERIC)
                 / NULLIF(patrimonio_liquido, 0) * 100, 2) AS roe_pct
    FROM financeiros WHERE data_ref = '2025-09-01'
)
SELECT i.nome, i.segmento, i.controle,
       f.ativo_total, f.carteira_credito,
       r.roe_pct, e.num_agencias
FROM instituicoes i
INNER JOIN financeiros f ON f.inst_id = i.id
INNER JOIN estrutura e  ON e.inst_id = i.id
INNER JOIN roe r        ON r.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND e.data_ref = '2025-09-01'
  AND i.segmento IN ('S1', 'S2')
ORDER BY f.ativo_total DESC;


-- ====================================================================
-- PARTE 7 -- ANALISE FINAL
-- Queries para o projeto final do modulo
-- ====================================================================

-- ------------------------------------------------------------
-- Visao geral do sistema financeiro
-- ------------------------------------------------------------

SELECT
    COUNT(*)                    AS total_instituicoes,
    SUM(f.ativo_total)          AS ativo_total_sistema,
    SUM(f.carteira_credito)     AS credito_total,
    SUM(f.lucro_liquido)        AS lucro_total,
    AVG(f.ativo_total)          AS ativo_medio,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY f.ativo_total) AS ativo_mediano
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01';


-- ------------------------------------------------------------
-- Concentracao por tipo de controle
-- ------------------------------------------------------------

SELECT
    i.controle,
    CASE i.controle
        WHEN '1' THEN 'Publico'
        WHEN '2' THEN 'Privado Nacional'
        WHEN '3' THEN 'Privado Estrangeiro'
    END AS tipo,
    COUNT(*)            AS qtd,
    SUM(f.ativo_total)  AS ativo_soma,
    ROUND(100.0 * SUM(f.ativo_total)
          / SUM(SUM(f.ativo_total)) OVER (), 1) AS pct_ativo
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
GROUP BY i.controle
ORDER BY ativo_soma DESC;


-- ------------------------------------------------------------
-- Bancos digitais vs tradicionais
-- ------------------------------------------------------------

SELECT
    CASE
        WHEN e.num_agencias = 0    THEN 'Digital (sem agencias)'
        WHEN e.num_agencias <= 10  THEN 'Hibrido (ate 10 agencias)'
        ELSE 'Tradicional (10+ agencias)'
    END AS tipo_operacao,
    COUNT(*)                AS qtd,
    SUM(f.ativo_total)      AS ativo_soma,
    AVG(f.carteira_credito) AS credito_medio
FROM instituicoes i
JOIN financeiros f ON f.inst_id = i.id
JOIN estrutura e  ON e.inst_id = i.id
WHERE f.data_ref = '2025-09-01'
  AND e.data_ref = '2025-09-01'
GROUP BY tipo_operacao
ORDER BY ativo_soma DESC;


-- ------------------------------------------------------------
-- Ranking completo de rentabilidade (ROE)
-- ------------------------------------------------------------

WITH roe_calc AS (
    SELECT
        i.nome, i.segmento, i.controle,
        f.ativo_total, f.patrimonio_liquido,
        f.lucro_liquido, e.num_agencias,
        ROUND(
            CAST(f.lucro_liquido AS NUMERIC)
            / NULLIF(f.patrimonio_liquido, 0) * 100, 2
        ) AS roe_pct
    FROM instituicoes i
    JOIN financeiros f ON f.inst_id = i.id
    JOIN estrutura e  ON e.inst_id = i.id
    WHERE f.data_ref = '2025-09-01'
      AND e.data_ref = '2025-09-01'
      AND f.patrimonio_liquido > 0
)
SELECT nome, segmento, controle,
       ativo_total, roe_pct, num_agencias,
    CASE
        WHEN roe_pct > 15 THEN 'Excelente'
        WHEN roe_pct > 8  THEN 'Bom'
        WHEN roe_pct > 0  THEN 'Fraco'
        ELSE 'Prejuizo'
    END AS avaliacao
FROM roe_calc
ORDER BY roe_pct DESC;


/*
======================================================================
  FIM DO ARQUIVO -- M4_IFdata_Pratica.sql

  Proximos passos:
  1. Adicione seus comentarios nas queries que voce escreveu
  2. Documente os insights que encontrou na analise final
  3. Este arquivo sera o primeiro item do seu portfolio no GitHub (Modulo 7)

  Dica: use o Claude.ai para revisar suas queries.
  Cole a query e pergunte: "Esta query esta bem escrita? Tem como melhorar?"
======================================================================
*/