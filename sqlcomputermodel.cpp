#include "sqlcomputermodel.h"

#include <QDebug>
#include <QSqlError>
#include <QSqlRecord>
#include <QSqlQuery>
#include <QSqlField>

SqlComputerModel::SqlComputerModel(QObject *parent) : QSqlTableModel(parent)
{
    bool empty = false;
    QSqlQuery query;
    if (!QSqlDatabase::database().tables().contains("Computers")) {
        if (!query.exec(
            "create table if not exists Computers ("
                    "id INTEGER primary key autoincrement,"
                    "name TEXT,"
                    "year INTEGER,"
                    "type TEXT,"
                    "made INTEGER)")) {
        qFatal("Failed to query database: %s", qPrintable(query.lastError().text()));
        } else {
            empty = true;
        }
    }

    setTable("Computers");
    setSort(2, Qt::DescendingOrder);
    setEditStrategy(QSqlTableModel::OnFieldChange);
    if (empty) {
        QSqlRecord rec = record();
        rec.setValue("name", "Earth Simulator");
        rec.setValue("year", 2002);
        rec.setValue("type", "Vector");
        rec.setValue("made", 1);
        insertRecord(-1, rec);
    }
    select();
}

QString SqlComputerModel::filter() const
{
    return _filter;
}

void SqlComputerModel::setAFilter(const QString &filter)
{
    _filter = filter;

    if (_filter == "") {
        QSqlTableModel::setFilter("");
    } else {
        QSqlTableModel::setFilter(_filter_type + " LIKE '%" + _filter + "%'");
    }

    qDebug() << selectStatement();
    select();
    emit filterChanged();
    qDebug() << QSqlTableModel::filter();
}

QString SqlComputerModel::filterType() const
{
    return _filter_type;
}

void SqlComputerModel::setFilterType(const QString &filterType)
{
    if (filterType.toLower() == _filter_type) {
        return;
    }

    _filter_type = filterType.toLower();

    setAFilter(_filter);
    qDebug() << selectStatement();
    select();

    emit filterTypeChanged();
}

QVariant SqlComputerModel::data(const QModelIndex &idx, int role) const
{
    if (role < Qt::UserRole) {
        return QSqlTableModel::data(idx, role);
    }

    const QSqlRecord sqlRecord = record(idx.row());
    return sqlRecord.value(role - Qt::UserRole);
}

QHash<int, QByteArray> SqlComputerModel::roleNames() const
{
    QHash<int, QByteArray> computers;
    computers[Qt::UserRole] = "id";
    computers[Qt::UserRole + 1] = "name";
    computers[Qt::UserRole + 2] = "year";
    computers[Qt::UserRole + 3] = "type";
    computers[Qt::UserRole + 4] = "made";
    return computers;
}
