programa
{
	inclua biblioteca Util --> u
	inclua biblioteca Matematica --> mat

	funcao inicio()
	{
		// Contadores de votos por candidato
		inteiro joao = 0, maria = 0, pedro = 0, ana = 0, lucas = 0
		inteiro confirma = 0, total_votos = 0, i, ja_votou, relatorio, total_candidatos = 5
		real cpf, banco_cpfs[200] // Armazena os CPFs que já votaram
		cadeia nome = "nd", candidato = "nd", auditor = "auditor_123", senha

		enquanto(nome != "fim votação")
		{
			escreva("=====================================\n")
			escreva("       SISTEMA DE VOTAÇÃO ELETRÔNICA\n")
			escreva("=====================================\n")

			escreva("Digite seu nome completo: ")
			leia(nome)

			// Encerrar votação (modo auditor)
			se(nome == "auditor_123")
			{
				escreva("Senha: ")
				leia(senha)

				se(senha == "159753")
				{
					pare
				}
			}

			escreva("Digite seu CPF (apenas números): ")
			leia(cpf)

			limpa()

			escreva("=====================================\n")
			escreva("       SISTEMA DE VOTAÇÃO ELETRÔNICA\n")
			escreva("=====================================\n")

			// Verifica se o CPF já votou
			ja_votou = 0
			para(i = 0; i < total_votos; i = i + 1)
			{
				se(cpf == banco_cpfs[i])
				{
					ja_votou = 1
				}
			}

			se(ja_votou == 1)
			{
				escreva("\nOps! CPF já votou. Consulte o mesário.\n\n")
			}
			senao
			{
				// Menu de candidatos
				escreva("Escolha seu voto para PRESIDENTE:\n")
				escreva("1 - João\n")
				escreva("2 - Maria\n")
				escreva("3 - Pedro\n")
				escreva("4 - Ana\n")
				escreva("5 - Lucas\n")
				escreva("Seu voto: ")
				leia(candidato)
				escreva("\n")

				limpa()

				escreva("=====================================\n")
				escreva("       SISTEMA DE VOTAÇÃO ELETRÔNICA\n")
				escreva("=====================================\n")

				// Converte número para nome do candidato
				se(candidato == "1") candidato = "João"
				senao se(candidato == "2") candidato = "Maria"
				senao se(candidato == "3") candidato = "Pedro"
				senao se(candidato == "4") candidato = "Ana"
				senao se(candidato == "5") candidato = "Lucas"
				senao candidato = "nd" // Caso inválido

				se(candidato != "nd")
				{
					escreva("Você votou em ", candidato, ".\n")
					escreva("Pressione (1) para CONFIRMAR ou (2) para CANCELAR: ")
					leia(confirma)
				}
				senao
				{
					escreva("\nCANDIDATO INVÁLIDO! TENTE OUTRA VEZ.\n\n")
				}

				// Se confirmar, contabiliza voto
				se(confirma == 1)
				{
					escreva("Seu voto foi computado com sucesso!\n")

					// Armazena CPF no banco
					banco_cpfs[total_votos] = cpf
					total_votos = total_votos + 1

					// Incrementa contador do candidato escolhido
					se(candidato == "João") joao++
					senao se(candidato == "Maria") maria++
					senao se(candidato == "Pedro") pedro++
					senao se(candidato == "Ana") ana++
					senao se(candidato == "Lucas") lucas++
				}
				senao
				{
					escreva("VOTO CANCELADO. Retornando ao menu principal...\n\n")
				}

				u.aguarde(5000) // Aguarda 5 segundos antes de retornar
				limpa()
			}
		}

		// Relatório do auditor
		escreva("Olá, auditor(a)! Digite 1 e pressione CONFIRMA para gerar o relatório de votos:\n")
		leia(relatorio)

		limpa()

		// Cálculo de porcentagem dos votos
		real pct_joao = (joao * 1.0 / total_votos) * 100
		real pct_maria = (maria * 1.0 / total_votos) * 100
		real pct_pedro = (pedro * 1.0 / total_votos) * 100
		real pct_ana = (ana * 1.0 / total_votos) * 100
		real pct_lucas = (lucas * 1.0 / total_votos) * 100

		se(relatorio == 1)
		{
			escreva("\n=====================================\n")
			escreva("          RESULTADO FINAL\n")
			escreva("=====================================\n")

			se(total_votos > 0)
			{
				escreva("1 - João: ", mat.arredondar(pct_joao, 2), "% (", joao, " votos)\n")
				escreva("2 - Maria: ", mat.arredondar(pct_maria, 2), "% (", maria, " votos)\n")
				escreva("3 - Pedro: ", mat.arredondar(pct_pedro, 2), "% (", pedro, " votos)\n")
				escreva("4 - Ana: ", mat.arredondar(pct_ana, 2), "% (", ana, " votos)\n")
				escreva("5 - Lucas: ", mat.arredondar(pct_lucas, 2), "% (", lucas, " votos)\n")
				escreva("=====================================\n")
				escreva("Total de votos válidos: ", total_votos, "\n")
			}
			senao
			{
				escreva("Nenhum voto registrado!\n")
			}
		}

		// ==== REGRA DO SEGUNDO TURNO ====
		se(pct_joao > 50)
			escreva("\nJoão eleito no 1º turno com ", mat.arredondar(pct_joao, 2), " dos votos.")
		senao se(pct_maria > 50)
			escreva("\nMaria eleita no 1º turno com ", mat.arredondar(pct_maria, 2), " dos votos.")
		senao se(pct_pedro > 50)
			escreva("\nPedro eleito no 1º turno com ", mat.arredondar(pct_pedro, 2), " dos votos.")
		senao se(pct_ana > 50)
			escreva("\nAna eleita no 1º turno com ", mat.arredondar(pct_ana, 2), " dos votos.")
		senao se(pct_lucas > 50)
			escreva("\nLucas eleito no 1º turno com ", mat.arredondar(pct_lucas, 2), " dos votos.")
		senao
		{
			escreva("\nNenhum candidato obteve mais de 50% dos votos. Haverá 2º turno.\n")

			// Vetores auxiliares
			inteiro votos[5] = {joao, maria, pedro, ana, lucas}
			cadeia nomes[5] = {"João", "Maria", "Pedro", "Ana", "Lucas"}

			inteiro maior1 = -1, maior2 = -1
			cadeia cand1 = "", cand2 = ""

			para(i = 0; i < 5; i = i + 1)
			{
				se(votos[i] > maior1)
				{
					maior2 = maior1
					cand2 = cand1
					maior1 = votos[i]
					cand1 = nomes[i]
				}
				senao se(votos[i] > maior2)
				{
					maior2 = votos[i]
					cand2 = nomes[i]
				}
			}

			escreva("Irão para o 2º turno: ", cand1, " e ", cand2, ".\n")
		}
	}
}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 4870; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = {joao, 9, 10, 4}-{maria, 9, 20, 5}-{pedro, 9, 31, 5}-{ana, 9, 42, 3}-{lucas, 9, 51, 5}-{confirma, 10, 10, 8}-{i, 10, 41, 1}-{ja_votou, 10, 44, 8}-{relatorio, 10, 54, 9}-{banco_cpfs, 11, 12, 10}-{senha, 12, 65, 5}-{pct_joao, 129, 7, 8}-{pct_maria, 130, 7, 9}-{pct_pedro, 131, 7, 9}-{pct_ana, 132, 7, 7}-{pct_lucas, 133, 7, 9};
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */