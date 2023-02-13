getwd()
dados = read.csv2('SUP_IES_2019.CSV', header = TRUE, sep = '|')
cat_admin = dados$TP_CATEGORIA_ADMINISTRATIVA

dados$VL_DESPESA_PESSOAL_DOCENTE = as.numeric(dados$VL_DESPESA_PESSOAL_DOCENTE)/1e6
dados$VL_DESPESA_PESSOAL_TECNICO = as.numeric(dados$VL_DESPESA_PESSOAL_TECNICO)/1e6
dados$VL_DESPESA_PESSOAL_ENCARGO = as.numeric(dados$VL_DESPESA_PESSOAL_ENCARGO)/1e6
dados$VL_DESPESA_CUSTEIO = as.numeric(dados$VL_DESPESA_CUSTEIO)/1e6
dados$VL_DESPESA_INVESTIMENTO = as.numeric(dados$VL_DESPESA_INVESTIMENTO)/1e6
dados$VL_DESPESA_PESQUISA = as.numeric(dados$VL_DESPESA_PESQUISA)/1e6
dados$VL_DESPESA_OUTRA = as.numeric(dados$VL_DESPESA_OUTRA)/1e6
rec_prop = as.numeric(dados$VL_RECEITA_PROPRIA)/1e6

desp_doc = dados$VL_DESPESA_PESSOAL_DOCENTE
desp_tec = dados$VL_DESPESA_PESSOAL_TECNICO
desp_enc = dados$VL_DESPESA_PESSOAL_ENCARGO
desp_cust = dados$VL_DESPESA_CUSTEIO
desp_invest = dados$VL_DESPESA_INVESTIMENTO
desp_pesq = dados$VL_DESPESA_PESQUISA
desp_out = dados$VL_DESPESA_OUTRA
rec_prop = dados$VL_RECEITA_PROPRIA

summary(desp_doc)
sd(desp_doc)
var(desp_doc)

summary(desp_tec)
sd(desp_tec)
var(desp_tec)

summary(desp_enc)
sd(desp_enc)
var(desp_enc)

summary(desp_cust)
sd(desp_cust)
var(desp_cust)

summary(desp_invest)
sd(desp_invest)
var(desp_invest)

summary(desp_pesq)
sd(desp_pesq)
var(desp_pesq)

summary(desp_out)
sd(desp_out)
var(desp_out)

summary(rec_prop)
sd(rec_prop)
var(rec_prop)

Values = table(dados$TP_CATEGORIA_ADMINISTRATIVA) 
labels =paste(names(Values))
pie(Values, labels = labels, main = 'Categoria Administrativa')

barplot(table(desp_doc))
barplot(table(desp_tec))
barplot(table(desp_enc))
barplot(table(desp_cust))
barplot(table(desp_invest))
barplot(table(desp_pesq))
barplot(table(desp_out))
barplot(table(rec_prop))

cor(desp_doc,rec_prop)
cor(desp_tec,rec_prop)
cor(desp_enc,rec_prop)
cor(desp_cust,rec_prop)
cor(desp_invest,rec_prop)
cor(desp_pesq,rec_prop)
cor(desp_out,rec_prop)

cor(desp_doc,desp_enc)
cor(desp_doc,desp_cust)
cor(desp_doc,desp_invest)
cor(desp_doc,desp_out)

cor(desp_enc,desp_cust)
cor(desp_enc,desp_invest)
cor(desp_enc,desp_out)

cor(desp_cust,desp_invest)
cor(desp_cust,desp_out)

cor(desp_invest,desp_out)

ggplot(dados, aes(x = as.numeric(VL_DESPESA_PESSOAL_DOCENTE)/1e6, y = as.numeric(VL_RECEITA_PROPRIA)/1e6)) +
  geom_point()
ggplot(dados, aes(x = desp_cust, y = rec_prop)) +
  geom_point()
ggplot(dados, aes(x = desp_invest, y = rec_prop)) +
  geom_point()

boxplot(desp_doc, desp_cust, desp_invest, rec_prop)
boxplot(desp_doc[desp_doc != 0], desp_cust[desp_cust != 0], desp_invest[desp_invest != 0], rec_prop[rec_prop != 0])

regressao = lm(rec_prop~desp_doc+desp_cust+desp_invest)
as.numeric(dados$VL_RECEITA_PROPRIA) - regressao$fitted.values * 1e6
hist(regressao$residuals, main = 'Histograma de resíduos', ylab = 'Resíduos')
boxplot(regressao$residuals)  

#MC

ModeloAjustado2 = 0
ErroAbsoluto2 = 0
ErroMedioQuadratico2 = 0

#inicio do LOOP de MONTE CARLO
for (i in 1:50){
  ind = createDataPartition(dados$VL_RECEITA_PROPRIA,p = 2/3, list = FALSE)
  train.data = dados[ind, ]
  test.data = dados[-ind, ]
  modelo2 =lm(VL_RECEITA_PROPRIA ~ VL_DESPESA_OUTRA + VL_DESPESA_PESQUISA + VL_DESPESA_PESSOAL_ENCARGO + VL_DESPESA_PESSOAL_TECNICO + VL_DESPESA_PESSOAL_DOCENTE + VL_DESPESA_CUSTEIO + VL_DESPESA_INVESTIMENTO, data = train.data)
  ValoresPreditos2 = predict(modelo2,newdata=data.frame(test.data))
  ModeloAjustado2 [i] = R2(ValoresPreditos2, test.data$VL_RECEITA_PROPRIA)
  ErroAbsoluto2 [i] = MAE(ValoresPreditos2, test.data$VL_RECEITA_PROPRIA)
  ErroMedioQuadratico2 [i] = RMSE(ValoresPreditos2, test.data$VL_RECEITA_PROPRIA)
}
mean(ModeloAjustado2)
mean(ErroAbsoluto2)
mean(ErroMedioQuadratico2)

ModeloAjustado3 = 0
ErroAbsoluto3 = 0
ErroMedioQuadratico3 = 0

#inicio do LOOP de MONTE CARLO
for (i in 1:50){
  ind = createDataPartition(dados$VL_RECEITA_PROPRIA,p = 2/3, list = FALSE)
  train.data = dados[ind, ]
  test.data = dados[-ind, ]
  modelo3 =lm(VL_RECEITA_PROPRIA ~ VL_DESPESA_CUSTEIO , data = train.data)
  ValoresPreditos3 = predict(modelo3,newdata=data.frame(test.data))
  ModeloAjustado3 [i] = R2(ValoresPreditos3, test.data$VL_RECEITA_PROPRIA)
  ErroAbsoluto3 [i] = MAE(ValoresPreditos3, test.data$VL_RECEITA_PROPRIA)
  ErroMedioQuadratico3 [i] = RMSE(ValoresPreditos3, test.data$VL_RECEITA_PROPRIA)
}
mean(ModeloAjustado3)
mean(ErroAbsoluto3)
mean(ErroMedioQuadratico3)

shapiro.test(dados$VL_RECEITA_PROPRIA)
ks.test(dados$VL_RECEITA_PROPRIA,'pnorm',mean(dados$VL_RECEITA_PROPRIA),sd(dados$VL_RECEITA_PROPRIA))

shapiro.test(dados$VL_DESPESA_PESSOAL_DOCENTE)
ks.test(dados$VL_DESPESA_PESSOAL_DOCENTE,'pnorm',mean(dados$VL_DESPESA_PESSOAL_DOCENTE),sd(dados$VL_DESPESA_PESSOAL_DOCENTE))

shapiro.test(dados$VL_DESPESA_PESSOAL_TECNICO)
ks.test(dados$VL_DESPESA_PESSOAL_TECNICO,'pnorm',mean(dados$VL_DESPESA_PESSOAL_TECNICO),sd(dados$VL_DESPESA_PESSOAL_TECNICO))

shapiro.test(dados$VL_DESPESA_PESSOAL_ENCARGO)
ks.test(dados$VL_DESPESA_PESSOAL_ENCARGO,'pnorm',mean(dados$VL_DESPESA_PESSOAL_ENCARGO),sd(dados$VL_DESPESA_PESSOAL_ENCARGO))

shapiro.test(dados$VL_DESPESA_CUSTEIO)
ks.test(dados$VL_DESPESA_CUSTEIO,'pnorm',mean(dados$VL_DESPESA_CUSTEIO),sd(dados$VL_DESPESA_CUSTEIO))

shapiro.test(dados$VL_DESPESA_INVESTIMENTO)
ks.test(dados$VL_DESPESA_INVESTIMENTO,'pnorm',mean(dados$VL_DESPESA_INVESTIMENTO),sd(dados$VL_DESPESA_INVESTIMENTO))

shapiro.test(dados$VL_DESPESA_PESQUISA)
ks.test(dados$VL_DESPESA_PESQUISA,'pnorm',mean(dados$VL_DESPESA_PESQUISA),sd(dados$VL_DESPESA_PESQUISA))

shapiro.test(dados$VL_DESPESA_OUTRA)
ks.test(dados$VL_DESPESA_OUTRA,'pnorm',mean(dados$VL_DESPESA_OUTRA),sd(dados$VL_DESPESA_OUTRA))

hist(dados$VL_RECEITA_PROPRIA)
hist(dados$VL_DESPESA_PESSOAL_DOCENTE)
hist(dados$VL_DESPESA_PESSOAL_TECNICO)
hist(dados$VL_DESPESA_PESSOAL_ENCARGO)
hist(dados$VL_DESPESA_CUSTEIO)
hist(dados$VL_DESPESA_INVESTIMENTO)
hist(dados$VL_DESPESA_PESQUISA)
hist(dados$VL_DESPESA_OUTRA)

t.test(dados$VL_DESPESA_PESSOAL_DOCENTE,dados$VL_DESPESA_PESSOAL_TECNICO, alternative = c("two.sided"))

boxplot(dados$VL_RECEITA_PROPRIA ~ dados$TP_CATEGORIA_ADMINISTRATIVA)
boxplot(dados$VL_DESPESA_PESSOAL_DOCENTE ~ dados$TP_CATEGORIA_ADMINISTRATIVA)
boxplot(dados$VL_DESPESA_PESSOAL_TECNICO ~ dados$TP_CATEGORIA_ADMINISTRATIVA)
boxplot(dados$VL_DESPESA_PESSOAL_ENCARGO ~ dados$TP_CATEGORIA_ADMINISTRATIVA)
boxplot(dados$VL_DESPESA_CUSTEIO ~ dados$TP_CATEGORIA_ADMINISTRATIVA)
boxplot(dados$VL_DESPESA_INVESTIMENTO ~ dados$TP_CATEGORIA_ADMINISTRATIVA)
boxplot(dados$VL_DESPESA_PESQUISA ~ dados$TP_CATEGORIA_ADMINISTRATIVA)
boxplot(dados$VL_DESPESA_OUTRA ~ dados$TP_CATEGORIA_ADMINISTRATIVA)

summary(aov(dados$VL_RECEITA_PROPRIA ~ dados$TP_CATEGORIA_ADMINISTRATIVA))
summary(aov(dados$VL_DESPESA_PESSOAL_DOCENTE ~ dados$TP_CATEGORIA_ADMINISTRATIVA))
summary(aov(dados$VL_DESPESA_PESSOAL_TECNICO ~ dados$TP_CATEGORIA_ADMINISTRATIVA))
summary(aov(dados$VL_DESPESA_PESSOAL_ENCARGO ~ dados$TP_CATEGORIA_ADMINISTRATIVA))
summary(aov(dados$VL_DESPESA_CUSTEIO ~ dados$TP_CATEGORIA_ADMINISTRATIVA))
summary(aov(dados$VL_DESPESA_INVESTIMENTO ~ dados$TP_CATEGORIA_ADMINISTRATIVA))
summary(aov(dados$VL_DESPESA_PESQUISA ~ dados$TP_CATEGORIA_ADMINISTRATIVA))
summary(aov(dados$VL_DESPESA_OUTRA ~ dados$TP_CATEGORIA_ADMINISTRATIVA))
