INSERT INTO
    PERSONALITIES (title, slug)
VALUES ('Realistic', 'realistic'), ('Artistic', 'artistic'), (
        'Investigative',
        'investigative'
    ), ('Social', 'social'), (
        'Enterprising',
        'enterprising'
    ), (
        'Conventional',
        'conventional'
    );

INSERT INTO
    MENUS (
        title,
        slug,
        menu_path,
        hasSubMenu
    )
VALUES ('Home', 'home', '/', false), (
        'Personality Profile',
        'personality-profile',
        '/personality-profile',
        true
    ), (
        'Courses and Programs',
        'courses-programs',
        '/courses-programs',
        true
    ), (
        'Resources',
        'resources',
        '/resources',
        false
    ), (
        'Others',
        'others',
        '/others',
        false
    ), (
        'Account Settings',
        'account',
        '/account',
        true
    );