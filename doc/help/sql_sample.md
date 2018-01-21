
### 稼働データの累積を取得する
```sql
SELECT
  t1.work_day,
  t1.total,
  SUM(t2.total) amount
FROM
  (
    SELECT
      work_day,
      SUM(work_hours) total
    FROM t_worked_hours
    GROUP BY work_day
  ) t1
INNER JOIN
  (
    SELECT
      work_day,
      SUM(work_hours) total
    FROM t_worked_hours
    GROUP BY work_day
    )t2
  ON t1.work_day >= t2.work_day
AND t1.work_day BETWEEN '2017-01-01' AND '2017-01-31'
GROUP BY t1.work_day, t1.total
ORDER BY t1.work_day
```

```
2017-01-04	365.19	365.19
2017-01-05	349.22	714.41
2017-01-06	386.65	1101.06
2017-01-07	15.00	1116.06
2017-01-08	2.00	1118.06
2017-01-09	8.00	1126.06
2017-01-10	434.31	1560.37
```