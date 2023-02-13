import pandas
from sklearn.model_selection import train_test_split
from sklearn import tree
from sklearn.preprocessing import LabelEncoder

#definindo os nomes de cada coluna   
names = ['num-pregnant', 'glucose', 'diastolic', 'triceps-skin', 'insulin', 'body-mass', 'diabetes-pedigree', 'age', 'class']

#Fazendo o carregamento dos dados diretamente do UCI Machine Learning          
dataset = pandas.read_csv("pima-indians-diabetes.csv", names=names)

print("Primeiros dados")
print(dataset.head(5))

#Convertendo dados categoricos para dados numericos
le = LabelEncoder()
for column_name in dataset.columns:
    if dataset[column_name].dtype == object:
        dataset[column_name] = le.fit_transform(dataset[column_name])
    else:
        pass

# print('Convertendo dados categóricos (usando Dummies)')
# dataset = pandas.get_dummies(dataset, prefix_sep='_', drop_first=True)

#divisao de dados atributos e classe
X = dataset.values[:, 0:7]
Y = dataset.values[:,8]

#usando o metodo para fazer uma unica divisao dos dados
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size = 0.25, random_state = 10)

#criando diferentes arvores
clf = tree.DecisionTreeClassifier(criterion='entropy',max_depth=10, random_state = 10)
clf2 = tree.DecisionTreeClassifier(max_depth=15,random_state = 10)

clf = clf.fit(X_train, y_train)
clf2 = clf2.fit(X_train, y_train)

print("Acuracia de trainamento clf: %0.3f" %  clf.score(X_train, y_train))
print("Acuracia de teste clf: %0.3f" %  clf.score(X_test, y_test))

print("Acuracia de trainamento clf2: %0.3f" %  clf2.score(X_train, y_train))
print("Acuracia de teste clf2: %0.3f" %  clf2.score(X_test, y_test))

print("Profundidade das arvores criadas")
print(clf.tree_.max_depth)
print(clf2.tree_.max_depth)