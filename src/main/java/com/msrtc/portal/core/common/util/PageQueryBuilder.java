package com.msrtc.portal.core.common.util;

import java.util.ArrayList;
import java.util.List;

// TODO: Auto-generated Javadoc

/**
 * The search query builder class responsible to hold the search attributes and helps generating the query.
 */
public class PageQueryBuilder {
	
	/** The select column. */
	private String selectColumn;

	private List<String> selectColumns = new ArrayList<String>();
	
	/** The tables. */
	private List<String> tables = new ArrayList<String>();
	
	/** The where conditions. */
	private List<String> whereConditions = new ArrayList<String>();

	/** The sort by. */
	private String sortBy;
	
	/** The count column. */
	private String countColumn;

	/**
	 * Gets the count column.
	 *
	 * @return the count column
	 */
	public String getCountColumn() {
		return countColumn;
	}

	/**
	 * Sets the count column.
	 *
	 * @param countColumn the new count column
	 */
	public void setCountColumn(String countColumn) {
		this.countColumn = countColumn;
	}

	/**
	 * Gets the select column.
	 *
	 * @return the select column
	 */
	public String getSelectColumn() {
		return selectColumn;
	}

	/**
	 * Sets the select column.
	 *
	 * @param selectColumn the new select column
	 */
	public void setSelectColumn(String selectColumn) {
		this.selectColumn = selectColumn;
	}

	public List<String> getSelectColumns() {
		return selectColumns;
	}

	public void setSelectColumns(List<String> selectColumns) {
		this.selectColumns = selectColumns;
	}

	/**
	 * Gets the sort by.
	 *
	 * @return the sort by
	 */
	public String getSortBy() {
		return sortBy;
	}

	/**
	 * Sets the sort by.
	 *
	 * @param sortBy the new sort by
	 */
	public void setSortBy(String sortBy) {
		this.sortBy = sortBy;
	}

	/**
	 * Gets the tables.
	 *
	 * @return the tables
	 */
	public List<String> getTables() {
		return tables;
	}

	/**
	 * Sets the tables.
	 *
	 * @param tables the new tables
	 */
	public void setTables(List<String> tables) {
		this.tables = tables;
	}

	/**
	 * Gets the where conditions.
	 *
	 * @return the where conditions
	 */
	public List<String> getWhereConditions() {
		return whereConditions;
	}

	/**
	 * Sets the where conditions.
	 *
	 * @param whereConditions the new where conditions
	 */
	public void setWhereConditions(List<String> whereConditions) {
		this.whereConditions = whereConditions;
	}

	/**
	 * Gets the result query.
	 *
	 * @return the result query
	 */
	public String getResultQuery() {
		StringBuilder sb = getCommonQueryString();
		sb.insert(0, "select " + getSelectColumnsSring() + " from ");
		sb.append(" order by " + sortBy);
		return sb.toString();
	}

	/**
	 * Gets the count query.
	 *
	 * @return the count query
	 */
	public String getCountQuery() {
		StringBuilder sb = getCommonQueryString();
		sb.insert(0, "select count(distinct " + countColumn + ") from ");
		return sb.toString();
	}

	public StringBuilder getSelectColumnsSring(){
		StringBuilder sb = new StringBuilder("");

		if (selectColumns.size() > 0) {
			for (int i = 0; i < selectColumns.size(); i++) {
				sb.append(selectColumns.get(i));
				if (i < selectColumns.size() - 1) {
					sb.append(", ");
				}
			}
		}

		return sb;
	}

	/**
	 * Gets the common query string.
	 *
	 * @return the common query string
	 */
	public StringBuilder getCommonQueryString() {
		StringBuilder sb = new StringBuilder("");
		if (tables.size() > 0) {
			for (int i = 0; i < tables.size(); i++) {
				sb.append(tables.get(i));
				if (i < tables.size() - 1) {
					sb.append(", ");
				}
			}
		}
		if (whereConditions.size() > 0) {
			sb.append(" where ");
			for (int i = 0; i < whereConditions.size(); i++) {
				sb.append(whereConditions.get(i));
				if (i < whereConditions.size() - 1) {
					sb.append(" and ");
				}
			}
		}
		return sb;
	}

	/**
	 * Gets the like query condition.
	 *
	 * @param property the property
	 * @param value the value
	 * @return the like query condition
	 */
	public String getLikeQueryCondition(String property, String value) {
		return property + " like '%" + value + "%'";
	}

	/**
	 * Adds the table.
	 *
	 * @param table the table
	 */
	public void addTable(String table) {
		this.getTables().add(table);
	}

	/**
	 * Adds the where condition.
	 *
	 * @param clause the clause
	 */
	public void addWhereCondition(String clause) {
		this.getWhereConditions().add(clause);
	}

}
