# BigQuery vs Snowflake : Guide comparatif

## 🎯 Différences syntaxe SQL

| Fonction | BigQuery | Snowflake |
|----------|----------|-----------|
| **Extraire année** | `EXTRACT(YEAR FROM date)` | `YEAR(date)` |
| **Truncate date** | `DATE_TRUNC(date, MONTH)` | `DATE_TRUNC('MONTH', date)` |
| **Date diff** | `DATE_DIFF(d1, d2, DAY)` | `DATEDIFF(DAY, d2, d1)` |
| **Backticks** | Obligatoires `` `table` `` | Optionnels |
| **Notation** | `project.dataset.table` | `database.schema.table` |
| **Status codes** | Texte ('Complete') | Codes ('F', 'O', 'P') |

## 🏗️ Architecture

### BigQuery
- ✅ Serverless total (0 gestion)
- ✅ Facturation : $5/TB scanné
- ✅ Partitioning automatique
- ✅ Clustering manuel
- ✅ Intégré GCP (Looker, Vertex AI)
- ❌ Lock-in Google Cloud

### Snowflake
- ✅ Warehouses (compute on-demand)
- ✅ Facturation : $2-32/h warehouse
- ✅ Micro-partitions automatiques
- ✅ Clustering manuel
- ✅ Multi-cloud (AWS, Azure, GCP)
- ✅ Data Sharing unique
- ❌ Plus cher si mal optimisé

## 📊 Comparaison Performance

| Aspect | BigQuery | Snowflake |
|--------|----------|-----------|
| **Requêtes simples** | 🥇 Très rapide | 🥈 Rapide |
| **Requêtes complexes** | 🥈 Rapide | 🥇 Très rapide |
| **Concurrence** | 🥇 Illimitée | 🥈 Limitée par warehouse |
| **Cache** | 🥇 24h gratuit | 🥇 24h gratuit |

## 💰 Coûts

### BigQuery
```
Requête scannant 1TB = $5
Requête quotidienne = $150/mois
Optimisée (100GB) = $15/mois
```

### Snowflake
```
Warehouse XSMALL 8h/jour = $480/mois
Auto-suspend 1 min = $50/mois
Bien optimisé = $100-200/mois
```

## 🎯 Quand utiliser quoi ?

### Choisir BigQuery si :
- ✅ Déjà dans écosystème GCP
- ✅ Budget limité (pay-per-query)
- ✅ Besoin ML intégré (BigQuery ML)
- ✅ Startup/Scale-up
- ✅ Équipe < 5 personnes

### Choisir Snowflake si :
- ✅ Besoin multi-cloud (flexibilité)
- ✅ Data Sharing critique (clients/partenaires)
- ✅ Équipe analytique 5-20 personnes
- ✅ Enterprise (>100 users)
- ✅ Workloads prédictibles

## 🔄 Migration BigQuery → Snowflake

**Principales modifications nécessaires :**

1. **Extraction dates**
```sql
   -- BigQuery
   EXTRACT(YEAR FROM order_date)
   
   -- Snowflake
   YEAR(order_date)
```

2. **Date truncate**
```sql
   -- BigQuery
   DATE_TRUNC(order_date, MONTH)
   
   -- Snowflake
   DATE_TRUNC('MONTH', order_date)
```

3. **Backticks**
```sql
   -- BigQuery
   FROM `project.dataset.table`
   
   -- Snowflake
   FROM database.schema.table
```

4. **Division décimale**
```sql
   -- BigQuery
   SELECT revenue / total
   
   -- Snowflake
   SELECT revenue * 1.0 / total
```

## 📚 Ressources

- [Snowflake Documentation](https://docs.snowflake.com/)
- [BigQuery Documentation](https://cloud.google.com/bigquery/docs)
- [Migration Guide](https://docs.snowflake.com/en/user-guide/migration-bigquery)