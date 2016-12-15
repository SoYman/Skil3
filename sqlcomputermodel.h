#ifndef SQLCOMPUTERMODEL_H
#define SQLCOMPUTERMODEL_H

#include <QSqlTableModel>

class SqlComputerModel : public QSqlTableModel
{
    Q_OBJECT
    Q_PROPERTY(QString filter READ filter WRITE setAFilter NOTIFY filterChanged)
    Q_PROPERTY(QString filterType READ filterType WRITE setFilterType NOTIFY filterTypeChanged)

public:

    SqlComputerModel(QObject *parent = 0);

    QString filter() const;
    void setAFilter(const QString &filter);

    QString filterType() const;
    void setFilterType(const QString &filterType);

    QVariant data(const QModelIndex &idx, int role) const Q_DECL_OVERRIDE;
    QHash<int, QByteArray> roleNames() const Q_DECL_OVERRIDE;

signals:
    void filterChanged();
    void filterTypeChanged();

private:
    QString _filter;
    QString _filter_type;
};

#endif // SQLCOMPUTERMODEL_H
