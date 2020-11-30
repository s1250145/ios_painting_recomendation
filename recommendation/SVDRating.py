# -*- coding: utf-8 -*-

# SVD recommend system

import numpy as np
import pandas as pd
import json

# original paint data set
data = json.load(open("PaintDataSet.json", "r"))

#
# ---- SGD process ----
#

def get_initial_values(x, k):
    # 各行列・ベクトルの値を0で初期化
    mu = np.sum(x) / np.count_nonzero(x)
    bu = (np.random.rand(x.shape[1]) - 0.5) * 0.1
    bi = (np.random.rand(x.shape[0]) - 0.5) * 0.1
    q = (np.random.rand(k, x.shape[0]) - 0.5) * 0.1
    p = (np.random.rand(k, x.shape[1]) - 0.5) * 0.1
    return (mu, bu, bi, q, p)

def get_error_matrix(x, mu, q, p, bu, bi):
    # 誤差e
    return x - (mu + np.dot(q.T, p) + bu + np.matrix(bi).T)

def error_function(x, mu, q, p, bu, bi, l):
    # 目的関数の定義
    # l = lambda
    error_matrix = get_error_matrix(x, mu, q, p, bu, bi)
    error = np.sum(np.square(error_matrix[x > 0])) # 0除外
    regularization = l * (np.sum(np.square(bu)) + np.sum(np.square(bi)) + np.sum(np.square(q)) + np.sum(np.square(p)))
    return error + regularization

def sgd(x, k, epochs=100, l=0.02, gamma=0.02):
    # SGDで分解した行列とバイアスを求める
    mu, bu, bi, q, p = get_initial_values(x, k)
    errors = []

    for epoch in range(epochs):
        error = error_function(x, mu, q, p, bu, bi, l)
        errors.append(error)

        # x>0となる要素のindexを取得
        Xi, Xu = np.where(x > 0)
        targets = np.arange(len(Xi))
        np.random.shuffle(targets)

        for target in targets:
            error_matrix = get_error_matrix(x, mu, q, p, bu, bi)

            i = Xi[target]
            u = Xu[target]

            e_ui = error_matrix[i, u]

            bu[u] = bu[u] + gamma * (e_ui - l * bu[u])
            bi[i] = bi[i] + gamma * (e_ui - l * bi[i])
            q[:, i] = q[:, i] + gamma * (e_ui * p[:, u] - l * q[:, i])
            p[:, u] = p[:, u] + gamma * (e_ui * q[:, i] - l * p[:, u])

    error = error_function(x, mu, q, p, bu ,bi, l)
    errors.append(error)
    print(f"Error: {error}")

    expected = mu + bu + np.matrix(bi).T + np.dot(q.T, p)

    return expected, errors

#
# --------
#

#
# ---- Data formatting ----
#

def check_same_name(dic, l):
    for i,j in enumerate(l):
        if j["img"] == dic["img"]:
            return i
        
        
def set_missing_value(arr, max_len):
    for item in arr:
        if len(item["rate"]) < max_len:
            for i in range(max_len - len(item["rate"])):
                item["rate"].append(0)
    return arr


def remove_distinct(json_arr):
    # ndarrayに変換する前に同じ絵画のデータをまとめる
    arr = []
    max_len = 1
    for dic in json_arr:
        flag = check_same_name(dic, arr)
        if flag is None:
            arr.append(dic)
        else:
            arr[flag]["rate"].extend(dic["rate"])
            if len(arr[flag]["rate"]) > max_len:
                max_len = len(arr[flag]["rate"])
    return set_missing_value(arr, max_len)


def jsonToNdarray(json_file):
    paint_name = []
    l = []
    for item in json_file:
        paint_name.append(item['img'])
        l.append(np.array(item['rate']))
    l_np = np.array(l)
    return paint_name, l_np

#
# --------
#


def sortDataSet(order):
    # 絵画のデータセットをレートが高い順に並び替える
    tmp = data.copy()
    new_data = []
                
    for i in order:
        paint = [j for j in tmp if j['imageName'] == i[0]]
        new_data.append(paint[0])
        tmp.remove(paint[0])
        
    new_data.extend(tmp)
    
    return new_data


def main(feeling, like):
    # argument type: json
    paint_name, X = jsonToNdarray(remove_distinct(feeling))
    paint_name, Y = jsonToNdarray(remove_distinct(like))
    
    k = X.shape[0]
    
    if X.shape[1] == 1:
        _X = X.copy()
        _Y = Y.copy()
        X = np.insert(_X, 1, 0, axis=1)
        Y = np.insert(_Y, 1, 0, axis=1)

    print("Feeling matrix\n", X)
    expected_x, errors = sgd(X, k)
    print(expected_x)

    print("\nLike matrix\n", Y)
    expected_y, errors = sgd(Y, k)
    print(expected_y)

    # calculate evaluation score before SVD
    evaluation_pt = X * Y
    evaluation_score = []
    for i in range(X.shape[0]):
        evaluation_score.append((evaluation_pt[i][0]+evaluation_pt[i][1]) / 2)

    # calculate recommend score after SVD
    recommend_pt = np.array(np.multiply(expected_x, expected_y))
    recommend_score = []
    for i in range(X.shape[0]):
        recommend_score.append((recommend_pt[i][0]+recommend_pt[i][1]) / 2)
    
    # desicion order of paint
    name = np.expand_dims(paint_name, axis=1)
    rate = np.expand_dims(np.array(recommend_score), axis=1)
    order_data = np.concatenate([name, rate], 1)

    # descending sort of order
    df_f = pd.DataFrame(order_data)
    df_s = df_f.sort_values(1, ascending=False)

    # order is final result of SVD recommendation
    order = df_s.values
    new_order = sortDataSet(order)
    
    if new_order is 0:
        new_order = data
    
    return new_order