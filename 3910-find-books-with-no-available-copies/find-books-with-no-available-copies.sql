SELECT 
    l.book_id, 
    l.title,
    l.author,
    l.genre,
    l.publication_year,
    COUNT(b.record_id) AS current_borrowers
FROM library_books l
JOIN borrowing_records b ON l.book_id = b.book_id
WHERE b.return_date IS NULL
GROUP BY l.book_id, l.title, l.author, l.genre, l.publication_year, l.total_copies
having count(b.record_id) = l.total_copies
order by current_borrowers desc, title asc