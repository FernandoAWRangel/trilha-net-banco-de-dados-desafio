--Baseando-se em cada necessidade das consultas também foi criada procedures retonando os dados fiel ao desafio

--1 - Buscar o nome e ano dos filmes
select Nome, Ano 
from Filmes

CREATE PROC BUSCAR_NOMEANO_FILMES '', 0
	@Nome varchar(255),
	@Ano int
as
if @Nome = '' set @Nome = null
if @Ano = 0 set @Ano = null
select 
	Nome, 
	Ano 
from Filmes
where
Nome = isnull(@Nome, Nome)
and Ano = isnull(@Ano, Ano)


--2 - Buscar o nome e ano dos filmes, ordenados por ordem crescente pelo ano
select 
	Nome, 
	Ano,
	Duracao
from Filmes
ORDER BY Ano

CREATE PROC BUSCAR_NOME_ANO_FILMES_ORDEM_CRESCENTE_POR_ANO '', 0
	@Nome varchar(255),
	@Ano int
as
if @Nome = '' set @Nome = null
if @Ano = 0 set @Ano = null
select 
	Nome, 
	Ano,
	Duracao
from Filmes
where
Nome = isnull(@Nome, Nome)
and Ano = isnull(@Ano, Ano)
ORDER BY Ano


--3 - Buscar pelo filme de volta para o futuro, trazendo o nome, ano e a duração
SELECT 
	Nome, 
	Ano, 
	Duracao
FROM Filmes
WHERE Id = 28

CREATE PROC BUSCAR_FILME_POR_ID 28
	@Id INT
AS
SELECT
	Nome, 
	Ano, 
	Duracao
FROM Filmes
WHERE Id = @Id


--4 - Buscar os filmes lançados em 1997
SELECT *FROM Filmes
WHERE Ano = 1997

CREATE PROC BUSCAR_FILMES_POR_ANO 1997
	@ANO INT
AS
SELECT *FROM Filmes
WHERE Ano = @ANO


--5 - Buscar os filmes lançados APÓS o ano 2000
SELECT 
	Nome,
	Ano,
	Duracao
FROM FILMES 
WHERE Ano > 2000

CREATE PROC BUSCAR_FILMES_APOS_ANO2000 0
	@Ano INT
AS
IF @Ano = 0 SET @Ano = NULL
SELECT 
	Nome,
	Ano,
	Duracao
FROM FILMES 
WHERE Ano > 2000


--6 - Buscar os filmes com a duracao maior que 100 e menor que 150, ordenando pela duracao em ordem crescente
SELECT 
	Nome,
	Ano,
	Duracao
FROM FILMES 
WHERE Duracao > 100
AND Duracao < 150
ORDER BY Duracao

CREATE PROC BUSCAR_FILME_POR_DURACAO 0
	@Duracao int
as 
IF @Duracao = 0 SET @Duracao = NULL
select
	Nome,
	Ano,
	Duracao
from Filmes
WHERE Duracao > 100
AND Duracao < 150
ORDER BY Duracao


--7 - Buscar a quantidade de filmes lançadas no ano, agrupando por ano, ordenando pela duracao em ordem decrescente
SELECT
	Ano,
	COUNT(*) Quantidade
FROM Filmes
WHERE Duracao <> ''
GROUP BY  Ano
ORDER BY Quantidade DESC

CREATE PROC BUSCAR_QUANTIDADE_FILMES_AGRUPADA_ANO_DURACAO_DECRESCENTE 0
	@Duracao int
as 
IF @Duracao = 0 SET @Duracao = NULL
SELECT
	Ano,
	COUNT(*) Quantidade
FROM Filmes
WHERE Duracao <> ''
GROUP BY  Ano
ORDER BY Quantidade DESC


--8 - Buscar os Atores do gênero masculino, retornando o PrimeiroNome, UltimoNome
SELECT 
	Id,
	PrimeiroNome, 
	UltimoNome,
	Genero
FROM Atores
WHERE Genero = 'M'

CREATE PROC BUSCAR_POR_GENERO_MASCULINO ''
	@Genero VARCHAR(1)
as
if @Genero = '' set @Genero = null
SELECT
	Id,
	PrimeiroNome, 
	UltimoNome,
	Genero
FROM
Atores
WHERE Genero = 'M'


--9 - Buscar os Atores do gênero feminino, retornando o PrimeiroNome, UltimoNome, e ordenando pelo PrimeiroNome
SELECT 
	Id,
	PrimeiroNome, 
	UltimoNome,
	Genero
FROM Atores
WHERE Genero = 'F'
ORDER BY PrimeiroNome

CREATE PROC BUSCAR_POR_GENERO_FEMININO_ORDENAR ''
	@Genero VARCHAR(1)
as
if @Genero = '' set @Genero = null
SELECT
	Id,
	PrimeiroNome, 
	UltimoNome,
	Genero
FROM
Atores
WHERE Genero = 'F'
ORDER BY PrimeiroNome


--10 - Buscar o nome do filme e o gênero
SELECT
	F.Nome,
	G.Genero
FROM FILMES AS F
INNER JOIN FilmesGenero AS FG ON  F.Id = FG.IdFilme 
INNER JOIN Generos AS G ON G.Id = FG.IdGenero


ALTER PROC BUSCAR_NOME_DO_FILME_GENERO ''
	@Nome varchar(50)
as
if @Nome = '' set @Nome = null
SELECT
	F.Nome,
	G.Genero
FROM FILMES AS F
INNER JOIN FilmesGenero AS FG ON  F.Id = FG.IdFilme 
INNER JOIN Generos AS G ON G.Id = FG.IdGenero
WHERE F.Nome = ISNULL(@Nome, F.Nome)


--11 - Buscar o nome do filme e o gênero do tipo "Mistério"
SELECT
	F.Nome,
	G.Genero 
FROM Filmes AS F
INNER JOIN FilmesGenero AS FG ON F.Id = FG.IdFilme
INNER JOIN Generos AS G ON G.Id = FG.IdGenero
WHERE G.Genero LIKE 'Mistério%'
-- OU
-- FG.IdGenero = 10

CREATE PROC BUSCAR_FILME_POR_GENERO0 0, ''
	@IdGenero INT,
	@Genero VARCHAR(20)
AS
SELECT
	F.Nome,
	G.Genero 
FROM Filmes AS F
INNER JOIN FilmesGenero AS FG ON F.Id = FG.IdFilme
INNER JOIN Generos AS G ON G.Id = FG.IdGenero
WHERE FG.IdGenero = 10 
AND G.Genero LIKE 'Mistério%'


--12 - Buscar o nome do filme e os atores, trazendo o PrimeiroNome, UltimoNome e seu Papel
SELECT
	F.NOME,
	A.PrimeiroNome,
	A.UltimoNome,
	EF.Papel
FROM Filmes AS F
INNER JOIN ElencoFilme AS EF ON F.Id = EF.IdFilme
INNER JOIN Atores AS A ON A.Id = EF.IdAtor


ALTER PROC BUSCAR_FILMES_ATORES_PAPEL ''
	@Nome VARCHAR(50)
AS
IF @Nome = '' SET @Nome = NULL
SELECT
	F.NOME,
	A.PrimeiroNome,
	A.UltimoNome,
	EF.Papel
FROM Filmes AS F
INNER JOIN ElencoFilme AS EF ON F.Id = EF.IdFilme
INNER JOIN Atores AS A ON A.Id = EF.IdAtor
WHERE Nome = ISNULL(@Nome, Nome)

