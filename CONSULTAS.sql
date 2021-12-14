--------- https://github.com/mielli/Banco_De_dados1 ---------




#---------------------------------------- CONSULTAS ---------------------------------------------------------------------------------

#1. Encontre à(às) Agencia(as) com maior quantidade de funcionarios que ganham acima de 5 mil rais. 
SELECT AEF.num_agencia, COUNT(F.salario)
FROM AGENCIA_EMPREGA_FUNCIONARIO AEF, FUNCIONARIO F 
WHERE AEF.cpf = F.cpf AND F.salario >= 5000
GROUP BY AEF.num_agencia;


#2. Encontre à(às) Agencia(as) com maior quantidade de funcionarios. 
SELECT AEF.num_agencia, COUNT(AEF.cpf)
FROM AGENCIA_EMPREGA_FUNCIONARIO AEF, FUNCIONARIO F 
WHERE AEF.cpf = F.cpf
GROUP BY AEF.num_agencia;


