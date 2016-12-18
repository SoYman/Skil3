#ifndef SQLINTERFACEMODEL_H
#define SQLINTERFACEMODEL_H

#include <QSqlTableModel>

class SqlInterfaceModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(QString table READ table WRITE setTable NOTIFY tableChanged)
    Q_PROPERTY(QString filter READ filter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(QString filterType READ filterType WRITE setFilterType NOTIFY filterTypeChanged)
    Q_PROPERTY(qint64 workingRow READ workingRow WRITE setWorkingRow NOTIFY workingRowChanged)

public:


    SqlInterfaceModel(QObject *parent = 0);

    QString table() const;
    void setTable(const QString &tableName) override;

    QString filter() const;
    void setFilter(const QString &filter) override;

    QString filterType() const;
    void setFilterType(const QString &filterType);

    qint64 workingRow() const;
    void setWorkingRow(qint64 &workingId);

    QVariant data(const QModelIndex &idx, int role) const Q_DECL_OVERRIDE;
//    bool setData(const QModelIndex &idx, const QVariant &val, int role) Q_DECL_OVERRIDE;

    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

    Q_INVOKABLE void setValue(const QString &field, const QVariant &val);

signals:
    void tableChanged();
    void filterChanged();
    void filterTypeChanged();
    void workingRowChanged();

private:
    QString _table;
    QString _filter;
    QString _filter_type;
    qint64 _working_row;
    bool _descending;

    qint64 _filterTypeEnum();
};

#endif // SQLINTERFACEMODEL_H
