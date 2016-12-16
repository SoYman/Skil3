#ifndef SQLINTERFACEMODEL_H
#define SQLINTERFACEMODEL_H

#include <QSqlTableModel>

class SqlInterfaceModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(QString table READ table WRITE setTable NOTIFY tableChanged)
    Q_PROPERTY(QString filter READ filter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(QString filterType READ filterType WRITE setFilterType NOTIFY filterTypeChanged)
    Q_PROPERTY(qint64 workingId READ workingId WRITE setWorkingId NOTIFY workingIdChanged)

public:


    SqlInterfaceModel(QObject *parent = 0);

    QString table() const;
    void setTable(const QString &tableName) override;

    QString filter() const;
    void setFilter(const QString &filter) override;

    QString filterType() const;
    void setFilterType(const QString &filterType);

    qint64 workingId() const;
    void setWorkingId(qint64 &workingId);

    QVariant data(const QModelIndex &idx, int role) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

signals:
    void tableChanged();
    void filterChanged();
    void filterTypeChanged();
    void workingIdChanged();

private:
    QString _table;
    QString _filter;
    QString _filter_type;
    qint64 _working_id;

    qint64 _filterTypeEnum();
};

#endif // SQLINTERFACEMODEL_H
