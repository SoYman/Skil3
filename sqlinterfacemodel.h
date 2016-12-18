#ifndef SQLINTERFACEMODEL_H
#define SQLINTERFACEMODEL_H

#include <QSqlRelationalTableModel>

class SqlInterfaceModel : public QSqlRelationalTableModel
{
    Q_OBJECT
    Q_PROPERTY(QString table READ table WRITE setTable NOTIFY tableChanged)
    Q_PROPERTY(QString filter READ filter WRITE setFilter NOTIFY filterChanged)
    Q_PROPERTY(QString filterType READ filterType WRITE setFilterType NOTIFY filterTypeChanged)
    Q_PROPERTY(qint64 workingRow READ workingRow WRITE setWorkingRow NOTIFY workingRowChanged)
    Q_PROPERTY(qint64 relationColumn READ relationColumn WRITE setRelationColumn NOTIFY relationColumnChanged)

public:


    SqlInterfaceModel(QObject *parent = 0);

    QString table() const;
    void setTable(const QString &tableName) override;

    QString filter() const;
    void setFilter(const QString &filter) override;

    QString filterType() const;
    // needs to be called explicitly to get correct sorting behaviour
    Q_INVOKABLE void setFilterType(const QString &filterType);

    qint64 workingRow() const;
    void setWorkingRow(qint64 &workingId);

    qint64 relationColumn() const;
    void setRelationColumn(qint64 &relationColumn);

    QVariant data(const QModelIndex &idx, int role) const Q_DECL_OVERRIDE;

    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

    Q_INVOKABLE bool insertRow(int row);
    Q_INVOKABLE void setIdSort();
    Q_INVOKABLE void setValue(const QString &field, const QVariant &val);
    Q_INVOKABLE bool removeWorkingRow();
    Q_INVOKABLE void makeRelation(const qint64 &computerId, const qint64 &personId);

signals:
    void tableChanged();
    void filterChanged();
    void filterTypeChanged();
    void workingRowChanged();
    void relationColumnChanged();

private:
    enum ComputerRole {
        id = Qt::UserRole,
        name,
        year,
        type,
        made
    };
    enum PeopleRole {
        born = Qt::UserRole + 2,
        died,
        gender,
        nationality
    };
    enum RelationRole {
        computer_id = Qt::UserRole + 1,
        person_id,
        relationship
    };

    QString _table;
    bool _is_relational;
    QString _filter;
    QString _filter_type;
    qint64 _working_row;
    qint64 _relation_column;
    Qt::SortOrder _sort_order;
};

#endif // SQLINTERFACEMODEL_H
