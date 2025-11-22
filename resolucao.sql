CREATE TABLE pessoa (
    matricula_pessoa INT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sexo CHAR(1) CHECK (sexo IN ('H', 'M')) NOT NULL
);


CREATE TABLE curso (
    codigo_curso INT PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE aluno (
    matricula_pessoa INT PRIMARY KEY,
    nota_vestibular DECIMAL(4, 2),
    codigo_curso INT NOT NULL,
    FOREIGN KEY (matricula_pessoa) REFERENCES pessoa(matricula_pessoa),
    FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_curso)
);


CREATE TABLE professor (
    matricula_pessoa INT PRIMARY KEY,
    data_admissao DATE NOT NULL,
    matricula_lider INT, 
    FOREIGN KEY (matricula_pessoa) REFERENCES pessoa(matricula_pessoa),
    FOREIGN KEY (matricula_lider) REFERENCES professor(matricula_pessoa)
);


CREATE TABLE disciplina (
    codigo_disciplina INT PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    ementa TEXT,
    conteudo_programatico TEXT,
    matricula_coordenador INT,
    FOREIGN KEY (matricula_coordenador) REFERENCES professor(matricula_pessoa)
);


CREATE TABLE turma (
    codigo_disciplina INT NOT NULL,
    codigo_curso INT NOT NULL,
    ano_semestre CHAR(6) NOT NULL,
    PRIMARY KEY (codigo_disciplina, codigo_curso, ano_semestre),
    FOREIGN KEY (codigo_disciplina) REFERENCES disciplina(codigo_disciplina),
    FOREIGN KEY (codigo_curso) REFERENCES curso(codigo_curso)
);


CREATE TABLE professor_turma (
    matricula_professor INT NOT NULL,
    codigo_disciplina INT NOT NULL,
    codigo_curso INT NOT NULL,
    ano_semestre CHAR(6) NOT NULL,
    PRIMARY KEY (matricula_professor, codigo_disciplina, codigo_curso, ano_semestre),
    FOREIGN KEY (matricula_professor) REFERENCES professor(matricula_pessoa),
    FOREIGN KEY (codigo_disciplina, codigo_curso, ano_semestre) REFERENCES turma(codigo_disciplina, codigo_curso, ano_semestre)
);


CREATE TABLE matricula (
    matricula_aluno INT NOT NULL,
    codigo_disciplina INT NOT NULL,
    codigo_curso INT NOT NULL,
    ano_semestre CHAR(6) NOT NULL,
    PRIMARY KEY (matricula_aluno, codigo_disciplina, codigo_curso, ano_semestre),
    FOREIGN KEY (matricula_aluno) REFERENCES aluno(matricula_pessoa),
    FOREIGN KEY (codigo_disciplina, codigo_curso, ano_semestre) REFERENCES turma(codigo_disciplina, codigo_curso, ano_semestre)
);


CREATE TABLE prova (
    matricula_aluno INT NOT NULL,
    codigo_disciplina INT NOT NULL,
    codigo_curso INT NOT NULL,
    ano_semestre CHAR(6) NOT NULL,
    descricao VARCHAR(50) NOT NULL, -- Ex: 1AV, 2AV, Final
    nota DECIMAL(3, 1) CHECK (nota BETWEEN 0.0 AND 10.0) NOT NULL,
    PRIMARY KEY (matricula_aluno, codigo_disciplina, codigo_curso, ano_semestre, descricao),
    FOREIGN KEY (matricula_aluno, codigo_disciplina, codigo_curso, ano_semestre) REFERENCES matricula(matricula_aluno, codigo_disciplina, codigo_curso, ano_semestre)
);


CREATE TABLE projeto (
    codigo_projeto INT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    pagina_web VARCHAR(255),
    conceito VARCHAR(10) CHECK (conceito IN ('Bom', 'Ruim', 'Regular'))
);


CREATE TABLE projeto_aluno (
    codigo_projeto INT NOT NULL,
    matricula_aluno INT NOT NULL,
    codigo_disciplina INT NOT NULL,
    codigo_curso INT NOT NULL,
    ano_semestre CHAR(6) NOT NULL,
    PRIMARY KEY (codigo_projeto, matricula_aluno, codigo_disciplina, codigo_curso, ano_semestre),
    FOREIGN KEY (codigo_projeto) REFERENCES projeto(codigo_projeto),
    FOREIGN KEY (matricula_aluno, codigo_disciplina, codigo_curso, ano_semestre) REFERENCES matricula(matricula_aluno, codigo_disciplina, codigo_curso, ano_semestre)
);


CREATE TABLE monitoria (
    matricula_monitor INT NOT NULL,
    codigo_disciplina INT NOT NULL,
    codigo_curso INT NOT NULL,
    ano_semestre CHAR(6) NOT NULL,
    matricula_professor_responsavel INT NOT NULL,
    PRIMARY KEY (matricula_monitor, codigo_disciplina, codigo_curso, ano_semestre),
    FOREIGN KEY (matricula_monitor) REFERENCES aluno(matricula_pessoa),
    FOREIGN KEY (codigo_disciplina, codigo_curso, ano_semestre) REFERENCES turma(codigo_disciplina, codigo_curso, ano_semestre),
    FOREIGN KEY (matricula_professor_responsavel) REFERENCES professor(matricula_pessoa)
);




INSERT INTO pessoa (matricula_pessoa, nome, sexo) VALUES (1111, 'Jose Alcantara', 'H');
INSERT INTO pessoa (matricula_pessoa, nome, sexo) VALUES (2222, 'Ricardo Nassau', 'H');
INSERT INTO pessoa (matricula_pessoa, nome, sexo) VALUES (3333, 'Maria das Dores', 'M');
INSERT INTO pessoa (matricula_pessoa, nome, sexo) VALUES (2727, 'Kelly Desarlinas', 'M');
INSERT INTO pessoa (matricula_pessoa, nome, sexo) VALUES (2828, 'Raphael Queiroga', 'H');
INSERT INTO pessoa (matricula_pessoa, nome, sexo) VALUES (2929, 'Carmelita Santos', 'M');


INSERT INTO curso (codigo_curso, nome) VALUES (1, 'Engenharia da Computacao');
INSERT INTO curso (codigo_curso, nome) VALUES (2, 'Ciencia da Computacao');
INSERT INTO curso (codigo_curso, nome) VALUES (3, 'Sistemas de Informacao');
INSERT INTO curso (codigo_curso, nome) VALUES (4, 'Analise de Sistemas');



INSERT INTO curso (codigo_curso, nome) VALUES (5, 'Engenharia da Eletrica');



-- LISTA DE SELECT QUE FORAM ADICIONADOS
SELECT matricula_pessoa, nome
FROM pessoa
WHERE sexo = 'H';



SELECT sexo, COUNT(*) AS total_pessoas
FROM pessoa
GROUP BY sexo;Z 'Z  '



SELECT nome
FROM curso
WHERE codigo_curso = 3;



SELECT codigo_curso, nome
FROM curso
WHERE nome LIKE 'Engenharia%';